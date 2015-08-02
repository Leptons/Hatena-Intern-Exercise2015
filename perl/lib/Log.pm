package Log;
use strict;
use warnings;

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub protocol {
    my ($self) = @_;
    if(!defined $self->{req}){
        return undef;
    }
    my $protocol = (split ' ', $self->{req})[2];
    return $protocol;
}

sub method {
    my ($self) = @_;
    if(!defined $self->{req}){
        return undef;
    }
    my $method = (split ' ', $self->{req})[0];
    return $method;
}

sub path {
    my ($self) = @_;
    if(!defined $self->{req}){
        return undef;
    }
    my $path = (split ' ', $self->{req})[1];
    return $path;
}

sub uri {
    my ($self) = @_;
    if(!defined $self->{host} || !defined $self->path){
        return undef;
    }
    my $uri = 'http://' . $self->{host} . $self->path;
    return $uri;
}

sub time {
    my ($self) = @_;
    if(!defined $self->{epoch}){
        return undef;
    }
    my ($sec, $min, $hour, $day, $month, $year) = gmtime $self->{epoch};
    my $time = sprintf "%04d-%02d-%02dT%02d:%02d:%02d", $year+1900, $month+1, $day, $hour, $min, $sec;
    return $time;
}

sub to_hash {
    my ($self) = @_;
    my %res;
    for (qw/status size user referer/){
        $res{$_} = $self->{$_} if defined $self->{$_};
    }
    $res{time} = $self->time if defined $self->{epoch};
    $res{uri} = $self->uri if defined $self->{host};
    $res{method} = $self->method if defined $self->{req};
    return \%res;
}

1;
