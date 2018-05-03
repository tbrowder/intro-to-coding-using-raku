#!/usr/bin/env perl6

=begin comment
while (<>) {
    if (/^\\begin\{Huge\}([^:]+): ([^\\]+)\\end\{Huge\}$/) {
        $_ = <<"EOT";
\\begin{Huge}$1\\end{Huge}

\\textit{$2}
EOT
    }

    print;
}
=end comment

while $*IN.read {
    say $_;

=begin comment
    if (/^\\begin\{Huge\}([^:]+): ([^\\]+)\\end\{Huge\}$/) {
        $_ = <<"EOT";
\\begin{Huge}$1\\end{Huge}

\\textit{$2}
EOT
    }
=end comment

    .print;
}
