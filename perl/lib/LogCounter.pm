package LogCounter;
use strict;
use warnings;

use Log;

sub new {
    my ($class, $logs) = @_;
    return bless { logs => $logs }, $class;
};

sub group_by_user {
    my ($self) = @_;
    my %res;
    for my $log (@{$self->{logs}}){
        my $user = $log->{user} // 'guest';
        push @{$res{$user}}, $log;
    }
    return \%res;
}

sub group_by_uri {
    my ($self) = @_;
    my %res;
    for my $log (@{$self->{logs}}){
        push @{$res{$log->path}}, $log if defined $log->uri;
    }
    return \%res;
}

sub count_error {
    my ($self) = @_;
    my $num_error = 0;
    for my $log (@{$self->{logs}}){
        $num_error++ if 500 <= $log->{status} && $log->{status} < 600;
    }
    return $num_error;
}

1;
