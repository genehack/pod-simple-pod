use 5;
package Pod::Simple::POD;
# ABSTRACT: Pod::Simple formatter that outputs POD
use strict;
use warnings;

#use Pod::Simple ();
use Pod::Simple::Methody ();
our @ISA = ('Pod::Simple::Methody');

sub new {
  my $self = shift;
  my $new = $self->SUPER::new(@_);
  $new->accept_targets('*');
  $new->keep_encoding_directive(1);
  $new->preserve_whitespace(1);
  $new->{buffer} = "=pod\n\n";
  return $new;
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sub handle_text       { $_[0]{buffer} .= $_[1] unless $_[0]{linkbuffer} }

# sub start_Document
sub start_head1       { $_[0]{buffer} .= '=head1 ' }
sub start_head2       { $_[0]{buffer} .= '=head2 ' }
sub start_head3       { $_[0]{buffer} .= '=head3 ' }
sub start_head4       { $_[0]{buffer} .= '=head4 ' }
sub start_encoding    { $_[0]{buffer} .= '=encoding ' }
# sub start_Para
# sub start_Verbatim

sub start_item_bullet { $_[0]{buffer} .= "=item *\n\n" }
# sub start_item_number
# sub start_item_text

sub end_item_bullet { $_[0]->emit }
#sub end_item_number { $_[0]->emit }
#sub end_item_text   { $_[0]->emit }

sub start_over_bullet  { $_[0]{buffer} .= '=over ' . $_[1]->{indent} . "\n\n"}
# sub start_over_number
# sub start_over_text
# sub start_over_block

sub end_over_bullet  { $_[0]->{buffer} .= '=back' . "\n\n" }
#sub end_over_number
#sub end_over_text
#sub end_over_block

sub end_Document    { print {$_[0]{'output_fh'} } "=cut\n" }

sub end_head1       { $_[0]->emit }
sub end_head2       { $_[0]->emit }
sub end_head3       { $_[0]->emit }
sub end_head4       { $_[0]->emit }
sub end_encoding    { $_[0]->emit }
sub end_Para        { $_[0]->emit }
sub end_Verbatim    { $_[0]->emit }

sub start_B { $_[0]{buffer} .= 'B<' }
sub end_B   { $_[0]{buffer} .= '>'  }
sub start_C { $_[0]{buffer} .= 'C<' }
sub end_C   { $_[0]{buffer} .= '>'  }
sub start_F { $_[0]{buffer} .= 'F<' }
sub end_F   { $_[0]{buffer} .= '>'  }
sub start_I { $_[0]{buffer} .= 'I<' }
sub end_I   { $_[0]{buffer} .= '>'  }
sub start_S { $_[0]{buffer} .= 'S<' }
sub end_S   { $_[0]{buffer} .= '>'  }
sub start_X { $_[0]{buffer} .= 'X<' }
sub end_X   { $_[0]{buffer} .= '>'  }

sub start_L { $_[0]{buffer} .= 'L<' . $_[1]->{raw} . '>' ; $_[0]->{linkbuffer} = 1 }
sub end_L   { $_[0]{linkbuffer} = 0 }

sub emit {
  my $self = shift;

  print { $self->{'output_fh'} } '',$self->{buffer},"\n\n";

  $self->{buffer} = '';

  return;
}

1;
