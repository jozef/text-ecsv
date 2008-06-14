package Text::ECSV;

=head1 NAME

Text::ECSV - Extended CSV manipulation routines

=head1 SYNOPSIS

    use Text::ECSV;
    $ecsv    = Text::ECSV->new ();         # create a new object
    $status  = $ecsv->parse ($line);       # parse a CSV string into fields
                                           #    and name value pairs
    %columns = $ecsv->fields_hash ();      # get the parsed field hash
    $column  = $ecsv->field_named('id');   # get field value for given name

=head1 DESCRIPTION

C< use base 'Text::CSV_XS'; > => see L<Text::CSV_XS>.

=cut

use warnings;
use strict;

our $VERSION = '0.01';

use base 'Text::CSV_XS', 'Class::Accessor::Fast';

=head1 PROPERTIES

=cut

__PACKAGE__->mk_accessors(qw{
    field_named
    fields_hash
});

=head1 METHODS

=head2 field_named($name)

Return field with $name.

=cut

sub field_named {
    my $self = shift;
    my $name = shift;
    
    return $self->fields_hash->{$name};
}


=head2 parse()

In aditional to the C<SUPER::parse()> functionality it decodes
name value pairs to fill in C<fields_hash>.

=cut

sub parse {
    my $self = shift;
    
    # reset fields hash
    $self->fields_hash({});
    
    # run Text::CSV_XS parse
    my $status = $self->SUPER::parse(@_);
    
    # if the CSV parsing was successfull then decode key name pairs
    if ($status) {
        foreach my $field ($self->fields) {
            # decode fields to name value pair
            if ($field =~ m/^([^=]+)=(.*)$/) {
                my $name  = $1;
                my $value = $2;
                
                $self->fields_hash->{$name} = $value;
            }
            # else fail
            else {
                $status = 0;
                # TODO fill error messages
                
                last;
            }
        }
    }
    
    return $status;
}

1;


__END__

=head1 TODO

    * $csv->combine(key => value, key2 => value)
    * handle multiple same keys on one line be "strategy"

=head1 AUTHOR

Jozef Kutej, C<< <jkutej@cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-text-ecsv at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Text-ECSV>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Text::ECSV


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Text-ECSV>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Text-ECSV>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Text-ECSV>

=item * Search CPAN

L<http://search.cpan.org/dist/Text-ECSV>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2008 Jozef Kutej, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1;
