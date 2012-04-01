<keyword>#!/usr/bin/env perl</keyword><normal>
</normal><normal>
</normal><comment># https://rt.cpan.org/Ticket/Display.html?id=76182</comment><comment>
</comment><keyword>my</keyword><normal> </normal><datatype>$underscore_bug</datatype><normal> = </normal><float>10</float><normal>_000;</normal><normal>
</normal><normal>
</normal><comment># https://rt.cpan.org/Ticket/Display.html?id=76168</comment><comment>
</comment><keyword>my</keyword><normal> </normal><datatype>$heredoc_bug</datatype><normal> =</normal><operator> <<</operator><keyword>'HEY';</keyword><normal>
</normal><keyword>HEY</keyword><normal>! <-</normal><operator>-</operator><normal> this is </normal><operator>not</operator><normal> the terminator</normal><normal>
</normal><normal>HEY</normal><normal>
</normal><normal>
</normal><comment># https://rt.cpan.org/Ticket/Display.html?id=76160</comment><comment>
</comment><normal>
</normal><comment>=head1 BORKED</comment><comment>
</comment><comment>
</comment><comment>All Perl code after this was considered a "comment" and Kate could not</comment><comment>
</comment><comment>highlight it correctly.</comment><comment>
</comment><comment>
</comment><comment>=cut</comment><comment>
</comment><comment>
</comment><comment>my $this_is_not_a_comment = 'or a pipe';</comment><comment>
</comment>