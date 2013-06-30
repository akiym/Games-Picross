package Games::Picross;
use 5.008005;
use strict;
use warnings;
use Carp ();

our $VERSION = "0.01";

sub new {
    my ($class, $picture) = @_;
    my $self = bless {
        picture   => [],
        width     => undef,
        height    => undef,
        v_hint    => [],
        h_hint    => [],
        base_calc => [0..9, 'A'..'Z'],
    }, $class;
    $self->_init_picture($picture);
    $self->_generate_hints;
    return $self;
}

sub _init_picture {
    my ($self, $picture) = @_;
    my @cols = split /\n/, $picture;
    my $width = length $cols[0];
    my $height = scalar @cols;
    my @picture;
    for my $col (@cols) {
        unless (length($col) == $width) {
            Carp::croak("${width}x$height");
        }
        push @picture, [split //, $col];
    }
    $self->{width} = $width;
    $self->{height} = $height;
    $self->{picture} = \@picture;
}

sub _generate_hints {
    my $self = shift;
    # vertical
    for my $h (0 .. $self->{width} - 1) {
        $self->{v_hint}[$h] = [];
        my $is_linked = 0;
        for my $v (reverse(0 .. $self->{height} - 1)) {
            if ($self->{picture}[$v][$h] == 1) {
                $is_linked++;
            } else {
                if ($is_linked) {
                    push @{$self->{v_hint}[$h]}, $is_linked;
                    $is_linked = 0;
                }
            }
        }
        if ($is_linked) {
            push @{$self->{v_hint}[$h]}, $is_linked;
        }
        unless (@{$self->{v_hint}[$h]}) {
            $self->{v_hint}[$h] = [0];
        }
    }
    # horizontal
    for my $v (0 .. $self->{height} - 1) {
        $self->{h_hint}[$v] = [];
        my $is_linked = 0;
        for my $h (reverse(0 .. $self->{width} - 1)) {
            if ($self->{picture}[$v][$h] == 1) {
                $is_linked++;
            } else {
                if ($is_linked) {
                    push @{$self->{h_hint}[$v]}, $is_linked;
                    $is_linked = 0;
                }
            }
        }
        if ($is_linked) {
            push @{$self->{h_hint}[$v]}, $is_linked;
        }
        unless (@{$self->{h_hint}[$v]}) {
            $self->{h_hint}[$v] = [0];
        }
    }
}

sub print_picross {
    my $self = shift;
    my $v_offset = $self->_max_hint_len($self->{v_hint});
    my $h_offset = $self->_max_hint_len($self->{h_hint});

    for my $i (reverse(0 .. $v_offset - 1)) {
        print((' ' x $h_offset) . '|');
        for my $hint (@{$self->{v_hint}}) {
            my $num = $hint->[$i];
            print defined $num ? $self->{base_calc}[$num] : ' ';
        }
        print "\n";
    }

    print(('-' x $h_offset) . '+' . ('-' x $self->{width}) . "\n");

    for my $hint (@{$self->{h_hint}}) {
        for my $i (reverse(0 .. $h_offset - 1)) {
            my $num = $hint->[$i];
            print defined $num ? $self->{base_calc}[$num] : ' ';
        }
        print '|' . (' ' x $self->{width}) . "\n";
    }
}

sub _max_hint_len {
    my ($self, $hint) = @_;
    my $max_len = 0;
    for my $h (@$hint) {
        my $len = scalar @$h;
        $max_len = $len > $max_len ? $len : $max_len;
    }
    return $max_len;
}

1;
__END__

=encoding utf-8

=head1 NAME

Games::Picross - Picross generator

=head1 SYNOPSIS

    use Games::Picross;

    my $picross = Games::Picross->new(<<'...');
    0000000000
    0000110000
    0001001000
    0001001000
    0010000100
    0010000100
    0111111110
    0100000010
    0100000010
    0000000000
    ...

    $picross->print_picross;

=head1 DESCRIPTION

Games::Picross is ...

=head1 METHODS

=head2 new

=head2 print_picross

=head1 LICENSE

Copyright (C) Takumi Akiyama.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Takumi Akiyama E<lt>t.akiym@gmail.comE<gt>

=cut

