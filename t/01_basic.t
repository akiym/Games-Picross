use strict;
use warnings;
use utf8;
use Test::More;
use Capture::Tiny qw/capture_stdout/;
use Games::Picross;

subtest 'new from string' => sub {
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
    isa_ok $picross, 'Games::Picross';
    is $picross->{width}, 10;
    is $picross->{height}, 10;
    is_deeply $picross->{picture}, [
        [qw/0 0 0 0 0 0 0 0 0 0/],
        [qw/0 0 0 0 1 1 0 0 0 0/],
        [qw/0 0 0 1 0 0 1 0 0 0/],
        [qw/0 0 0 1 0 0 1 0 0 0/],
        [qw/0 0 1 0 0 0 0 1 0 0/],
        [qw/0 0 1 0 0 0 0 1 0 0/],
        [qw/0 1 1 1 1 1 1 1 1 0/],
        [qw/0 1 0 0 0 0 0 0 1 0/],
        [qw/0 1 0 0 0 0 0 0 1 0/],
        [qw/0 0 0 0 0 0 0 0 0 0/],
    ];
};

subtest 'invalid string' => sub {
    eval {
        Games::Picross->new(<<'...');
0000000000
0000110000
0001001000
0001001000
0010000100
0010000100
0111111110
0100000010
0100000010
000000000
...
    };
    ok $@;
    like $@, qr/10x10/;
};

subtest 'picross' => sub {
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
    is_deeply $picross->{h_hint}, [
        [0],
        [2],
        [1, 1],
        [1, 1],
        [1, 1],
        [1, 1],
        [8],
        [1, 1],
        [1, 1],
        [0],
    ];
    is_deeply $picross->{v_hint}, [
        [0],
        [3],
        [3],
        [1, 2],
        [1, 1],
        [1, 1],
        [1, 2],
        [3],
        [3],
        [0],
    ];
    my $stdout = capture_stdout {
        $picross->print_picross;
    };
    is $stdout, <<'...';
  |   2112   
  |0331111330
--+----------
 0|          
 2|          
11|          
11|          
11|          
11|          
 8|          
11|          
11|          
 0|          
...
};

done_testing;
