#!/usr/bin/env perl

# https://rt.cpan.org/Ticket/Display.html?id=76182
my $underscore_bug = 10_000;

# https://rt.cpan.org/Ticket/Display.html?id=76168
my $heredoc_bug = <<'HEY';
HEY! <-- this is not the terminator
HEY

# https://rt.cpan.org/Ticket/Display.html?id=76160

=head1 BORKED

All Perl code after this was considered a "comment" and Kate could not
highlight it correctly.

=cut

my $this_is_not_a_comment = 'or a pipe';
