package Parser;
use strict;
use warnings;

use Log;

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub parse {
    my ($self) = @_;
    open my $fh, '<', $self->{filename} or die $!;
    my @res;
    while (<$fh>){
        chomp;
        my @log = map { /\A([^:]*?):(.*)\z/s; $1 => $2; } grep !/\A[^:]*:-\z/, split /\t/;
        push @res, Log->new(@log);
    }
    return \@res;
}

1;
