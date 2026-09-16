#!/usr/bin/env perl

use strict;
use warnings;
use JSON::PP;
use IPC::Open3 qw(open3);
use Symbol qw(gensym);

my $json = JSON::PP->new->utf8;

# read the json that vscode passes on stdin
my $raw = do { local $/; <STDIN> };
exit 0 if !defined $raw || $raw !~ /\S/;

my $event = eval { $json->decode($raw) };
exit 0 if ref $event ne 'HASH';

# only care about run_in_terminal
my $input = $event->{tool_input};
exit 0 if ($event->{tool_name} // '') ne 'run_in_terminal' || ref $input ne 'HASH';

my $command = $input->{command};
exit 0 if !defined $command || ref $command || $command !~ /\S/;

# `fish --no-execute` only parses: it reads the script from stdin and reports syntax errors on stderr
my ($in, $out, $err);
$out = gensym;
$err = gensym;

my $pid = eval { open3($in, $out, $err, 'fish', '--no-execute') };
exit 0 if !$pid;  # no fish on this machine: nothing we can check

binmode $in, ':encoding(UTF-8)';
print {$in} $command;
close $in;

my $diagnosis = do { local $/; <$err> };
close $out;

waitpid $pid, 0;
exit 0 if $? == 0;

$diagnosis =~ s/^\s+|\s+$//g;

print $json->encode({
  hookSpecificOutput => {
    hookEventName            => 'PreToolUse',
    permissionDecision       => 'deny',
    permissionDecisionReason => "Not valid fish syntax:\n$diagnosis",
    additionalContext        => 'The terminal runs fish, not bash. Rewrite the command in fish syntax and call runInTerminal again.',
  },
});

exit 0;
