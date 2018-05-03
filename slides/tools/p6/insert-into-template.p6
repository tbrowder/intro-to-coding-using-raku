#!/usr/bin/env perl6

=begin comment
my $body = join "", <>;
open my $TEMPLATE, "<", "src/template-exercises.tex";

for (join "", <$TEMPLATE>) {
    s/\{\{\{BODY\}\}\}/$body/;
    print;
}

close $TEMPLATE;
=end comment

my $body = join "", $*IN.lines;
my $TEMPLATE = "src/template-exercises.tex";

for join "", $TEMPLATE.IO.read {
    s/\{\{\{BODY\}\}\}/$body/;
    .print;
}

close $TEMPLATE;
