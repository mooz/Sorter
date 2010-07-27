package Sorter;

use strict;
use warnings;

# ============================================================ #
# >> Sorter Begins Here
# ============================================================ #

sub new {
    my ($class) = @_;

    bless {
        values => []
    }, $class;
}

# ============================================================ #
# Interfaces
# ============================================================ #

sub set_values {
    my $self = shift;

    $self->{values} = [];
    push (@{$self->{values}}, $_) for @_;
}

sub get_values {
    my $self = shift;

    return @{$self->{values}};
}

sub sort {
    my $self = shift;

    my $len  = @{$self->{values}};

    return if $len <= 1;

    $self->do_sort(0, $len - 1);
}

# ============================================================ #
# Private
# ============================================================ #

sub do_sort {
    my $self = shift;

    my $values = $self->{values};
    my $from   = shift;
    my $to     = shift;
    my $len    = $to - $from + 1;

    return if ($len < 2);

    my $cent  = $from + int(($len) / 2);
    my $centv = @$values[$cent];

    sub swap {
        my ($v, $i, $j) = @_;

        (@$v[$i], @$v[$j]) = (@$v[$j], @$v[$i]);
    }

    # bring centv to 0
    swap($values, $cent, $from);

    for (my $cur_i = $from + 1; $cur_i <= $to; $cur_i++) {
        next if (@$values[$cur_i] < $centv);

        for (my $target_i = $cur_i + 1; $target_i <= $to; $target_i++) {
            if (@$values[$target_i] <= $centv) {
                swap($values, $cur_i, $target_i);
                last;
            }
        }
    }

    my $up_begin = $from + 1;
    $up_begin++ while ($up_begin <= $to && @$values[$up_begin] <= $centv);

    my $new_cent = $up_begin - 1;
    swap($values, $from, $new_cent);

    $self->do_sort($from, $new_cent - 1);
    $self->do_sort($new_cent, $to);
}

# ============================================================ #
# Utils
# ============================================================ #

sub str {
    my $self = shift;
    return join(", ", @{$self->{values}});
}

sub p {
    print join(" ", @_) . "\n";
}

# ============================================================ #
# << Sorter Ends Here
# ============================================================ #

1;
