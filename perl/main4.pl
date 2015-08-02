use strict;
use warnings;

use Data::Dumper;
use List::Util qw/reduce/;

use Log;
use Parser;
use LogCounter;

my $parser = Parser->new( filename => '../sample_data/large_log.ltsv' );
my $counter = LogCounter->new($parser->parse);
my $uriLogs = $counter->group_by_uri;

for my $uri (keys %$uriLogs){
    print $uri."\n";
    my @countHour = (0) x 24;
    for my $log (@{$uriLogs->{$uri}}){
        my $time = $log->time;
        if($time =~ /T([0-9]+):/){
            $countHour[$1]++;
        }
    }

    my $sum = reduce {$a + $b} @countHour;
    if ($sum == 0){
        next;
    }
    my $scale = 96; # ダイアグラムの最大幅
    printf "-------------:%" . ${scale}/2 ."d%" . ${scale}/2 . "d %%\n", 50, 100;
    for (0..23){
        my $num = $countHour[$_]*$scale/$sum-1;
        printf "(%02d:00-%02d:59):", $_, $_;
        if($num >= 0){
            print '=' x $num . "o\n";
        } else {
            print "\n";
        }
    }
    print "\n";
}
