#!/usr/bin/perl -T
#
#  Author: Hari Sekhon
#  Date: 2014-06-07 22:17:09 +0100 (Sat, 07 Jun 2014)
#
#  http://github.com/harisekhon
#
#  License: see accompanying LICENSE file
#

$DESCRIPTION = "Program to show all the ASCII terminal code Foreground/Background color combinations in a terminal to make it easy to pick for writing fancy programs";

$VERSION = "0.1";

use strict;
use warnings;
BEGIN {
    use File::Basename;
    use lib dirname(__FILE__) . "/lib";
}
use HariSekhonUtils;

remove_timeout();
get_options();

autoflush();

my $text = "hari";
my $len  = length($text) + 2;

# effects 4 = underline, 5 = blink, look ugly
my @effects = qw/0 1/;

print "\nASCII Terminal Codes Color Key:\n\n";
printf "%5s BG %-${len}s  ", "", "none";
for(my $bg=40; $bg <= 47; $bg++){
    printf "  %-${len}s ", "${bg}m";
}
printf "\n %5s\n", "TXT";
sub print_line($){
    my $txt = shift;
    foreach my $effect (@effects){
        printf " %4sm ", $effect ? "$effect;$txt" : "$txt";
        printf "\e[0m\e[${txt}m  $text  \e[0m  ";
        for(my $bg=40; $bg <= 47; $bg++){
            printf "\e[$effect;${txt}m\e[${bg}m  $text  \e[0m ";
        }
        print "\n";
        last if $txt eq 0 or $txt eq 1;
    }
}
print_line 0;
print_line 1;
for(my $txt=30; $txt <= 37; $txt++){
    print_line $txt;
}
print "\n";

exit 0;
