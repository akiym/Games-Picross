use strict;
use warnings;
use utf8;
use Test::More;
use Test::Difflet qw/is_deeply/;
use Capture::Tiny qw/capture_stdout/;
use Games::Picross;

subtest 'seefood' => sub {
    my $picross = Games::Picross->new(<<'...');
000111111111111111111111111000
001000010000000000000000000100
001000111111111111111111111000
000111000000000000000000001000
000011111111111111111111110000
000010000000000000000000010000
000011010101010101010101010000
000011010101010101010101010000
000010000000000000000000010000
000011010101010101010101010000
000010000000111111000000010000
000011111001100101100000010000
000011001001010000100000010000
000011011001111111100000010000
000001011111111111111111100000
000001011001101100100010100000
000001101011010101101010100000
000001101001010100101010100000
000001101011000101101010100000
000001001001010101100010100000
000001111111111111111111100000
000001000000000000000000100000
000001000001111111000000100000
000001000000000000000000100000
000000110101010101010101000000
000000110101010101010101000000
000000100000000000000001000000
000000111111111111111111000000
000000100000000000000001000000
000000011111111111111110000000
...
    is $picross->{width}, 30;
    is $picross->{height}, 30;
    is_deeply $picross->{h_hint}, [
        [24],
        [1, 1, 1],
        [21, 1],
        [1, 3],
        [22],
        [1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
        [1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2],
        [1, 6, 1],
        [1, 2, 1, 2, 5],
        [1, 1, 1, 1, 1, 2],
        [1, 8, 2, 2],
        [18, 1],
        [1, 1, 1, 2, 2, 2, 1],
        [1, 1, 1, 2, 1, 1, 2, 1, 2],
        [1, 1, 1, 1, 1, 1, 1, 1, 2],
        [1, 1, 1, 2, 1, 2, 1, 2],
        [1, 1, 2, 1, 1, 1, 1, 1],
        [20],
        [1, 1],
        [1, 7, 1],
        [1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 2],
        [1, 1, 1, 1, 1, 1, 1, 1, 2],
        [1, 1],
        [18],
        [1, 1],
        [16],
    ];
    is_deeply $picross->{v_hint}, [
        [0],
        [0],
        [2],
        [1, 1],
        [11, 1],
        [13, 1, 2, 2, 1],
        [5, 1, 3, 1, 1, 1, 1],
        [1, 1, 2, 1, 3, 1, 1, 2, 1, 3],
        [1, 1, 10, 1, 1, 1],
        [1, 1, 2, 1, 1, 1, 2, 1, 1, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 1, 2, 1, 10, 1, 2, 1, 1, 1],
        [1, 1, 1, 1, 3, 2, 1, 1, 1],
        [1, 1, 2, 1, 2, 2, 3, 2, 2, 1, 1, 1],
        [1, 1, 1, 1, 3, 1, 1, 1, 1],
        [1, 1, 2, 1, 8, 3, 2, 1, 1, 1],
        [1, 1, 1, 1, 2, 1, 1, 1, 1],
        [1, 1, 2, 1, 3, 1, 2, 3, 2, 1, 1, 1],
        [1, 1, 10, 1, 1, 1],
        [1, 1, 2, 1, 1, 1, 2, 1, 1, 1],
        [1, 1, 1, 3, 1, 1, 1, 1],
        [1, 1, 2, 1, 1, 1, 2, 1, 1, 1],
        [1, 1, 7, 1, 1, 1],
        [5, 1, 1, 1, 2, 1, 1, 1],
        [10, 1, 1, 1],
        [10, 1, 1],
        [2, 1],
        [1],
        [0],
        [0],
    ];
    my $stdout = capture_stdout {
        $picross->print_picross;
    };
    is $stdout, <<'...';
           |             1   1            
           |             1   1            
           |       3 1 1 1 1 1 1 1        
           |       1 111121112 1 1        
           |       2 111121113 111 1      
           |      11 212131212 212 1      
           |      111111221311111111      
           |     113111A323823111112      
           |     21111111111111131111     
           |     232A212121212A2127111    
           |   111111111111111111111111   
           |0021BD511111111111111115AA2100
-----------+------------------------------
          O|                              
        111|                              
         1L|                              
         31|                              
          M|                              
         11|                              
21111111111|                              
21111111111|                              
         11|                              
21111111111|                              
        161|                              
      52121|                              
     211111|                              
       2281|                              
         1I|                              
    1222111|                              
  212112111|                              
  211111111|                              
   21212111|                              
   11111211|                              
          K|                              
         11|                              
        171|                              
         11|                              
  211111111|                              
  211111111|                              
         11|                              
          I|                              
         11|                              
          G|                              
...
};

done_testing;