#!/usr/bin/perl

while (my $line = <STDIN>) {
    print xmlEscape($line);
}

sub xmlEscape {
    my $str = shift or return;
    my %escaped = ( '&' => 'amp', '<' => 'lt', '>' => 'gt', '"' => 'quot' );
    my $cclass2escape = '[' . join('', keys %escaped) . ']';
    $str =~ s{(${cclass2escape})(?!amp;)}{'&' . $escaped{$1} . ';'}msxgeo;
    return $str;
}
