#!/usr/bin/env perl6

my $prog = $*PROGRAM.basename;

my $debug  = 0;
my $infile = 0;
my $usage  = "$prog: -i=<talk.md>";
$usage    ~= ' | --help | ? [--debug[=N]]'; # '~=' instead of '.='

# ARG/OPTION HANDLING ========================
# See [http://design.perl6.org/S06.html]
# for built-in methods similar to Getopts::Long
if !@*ARGS {
  say $usage ~ "\n"; # '~' instead of '.'
  exit;
}

for @*ARGS -> $arg is copy { # 'is copy' allows modifying locally
  my $oarg = $arg; # save original for error handling
  my $val  = '';  # 'Any' instead of 'undef'
  my $idx  = index($arg, '=');
  if $idx.defined && $idx >= 0 { # index is defined if an index is found
    $val = substr $arg, $idx+1; # use substr function
    $arg = substr $arg, 0, $idx;
    #say "DEBUG: arg = '$arg'";
    #say "DEBUG: val = '$val'";
    #die "DEBUG exit";
  }

  if $arg eq '-i' || $arg eq '--infile' {
    $infile = $val.IO:path.basename;
  }
  elsif $arg eq '-d' || $arg eq '--debug' {
    $debug = $val ?? $val !! 1;
  }
  elsif $arg eq '-h' || $arg eq '--help' || $arg eq q{?} {
    long-help;
  }
  else {
    die "FATAL:  Unknown argument '$oarg'.\n";
  }
}

# MAIN PROGRAM ========================
die "FATAL:  No such file '$infile'.\n"
  if !$infile.IO.f;

my $outfile = stemname($infile) ~ '.pdoc';

my @fo = [$outfile];

say "Working file '$infile'...";
# open input file
  my $fpi = open $infile;

  # open output file
  my $fpo = open $outfile, :w;

  # read the file and strip lines with certain dirs
  LINE:
  for $fpi.lines -> $line { # note that lines are already chomped

    #say "DEBUG line: '$line'";

    my $ifil = '';
    my $headers = False;
    # look for insertion files (<!-- insert-file <file name> -->
    if $line ~~ m/  ^ \s* '<!--' \s* 'insert-file' \s+ (<[\w\/\.\-]>+) \s* '-->' \s* $ / {
      say "DEBUG: found insertion line for file '$0'";
      $ifil = $0;
      $headers = True if $ifil ~~ /headers|closer/;
    }
    else {
      #say "DEBUG: no insertion line found";
      $fpo.say: $line;
      next LINE;
    }

    # skip if non-existent
    next LINE if !$ifil.IO.f; # 'ell'

    if !$headers {
      $fpo.say;
      $fpo.say: "<!-- inserting contents of file '$ifil' here: -->";
    }
    for $ifil.IO.lines -> $iline {
      $fpo.print: "$iline\n";
    }
    if !$headers {
      $fpo.say: "<!-- end of inserting contents of file '$ifil' -->";
      $fpo.say;
    }
}

for @fo {
  say "See output file '$_'";
}

#### subroutines ####
sub long-help {
  say $usage;
  say();
  say q:to/HERE/;
    Used to include files by adding one or lines like this:

      <!-- insert-file <filename> -->
  HERE
  exit;
}

sub stemname($prog) {
  my $idx = rindex $prog, '.';
  if $idx {
    return $prog.substr(0, $idx);
  }
  return $prog;
} # stemname
