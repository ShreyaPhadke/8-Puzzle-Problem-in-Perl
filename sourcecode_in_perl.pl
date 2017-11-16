#!/usr/bin/env perl
 
 use warnings;
 use strict;
 
 use Wx;
 use wxPerl::Constructors;
 
 package MyApp;
 
 use base 'Wx::App';
 
 #my globals
 my @button;
 my @v;
 my @a;
 my $i;
 my $j;
 my $k;
 my $t;
 my $dif=100;
 my $countzz=0;
 
 sub move{
   
   my ($b,$x,$y) = @_;
    
     my $tx=$x;
     my $ty=$y;
     
     if($a[$x][$y-1]==0){
       $ty--;
     }elsif($a[$x+1][$y]==0){
       $tx++;
     }elsif($a[$x][$y+1]==0){
       $ty++;
     }elsif($a[$x-1][$y]==0){
       $tx--;
     }else{
       return;
     }
     
     $b->SetLabel(' ');
     $b->Disable;
     $a[$x][$y]=0;
     
     $button[3*($tx-1)+$ty-1]->Enable;
     $a[$tx][$ty]=1;
     
     $t=$v[$x][$y];
     $v[$x][$y]=$v[$tx][$ty];
     $v[$tx][$ty]=$t;
     $button[3*($tx-1)+$ty-1]->SetLabel($t+1);
	 
	 $countzz++;
     
     if($v[1][1]==0&&$v[1][2]==1&&$v[1][3]==2&&$v[2][1]==3&&$v[2][2]==4&&$v[2][3]==5&&$v[3][1]==6&&$v[3][2]==7&&$v[3][3]==8){
       for($i=0;$i<9;$i++){
         $button[$i]->Disable;
       }
       $button[8]->SetLabel("Total Steps:\n$countzz");
     }
     
   }
   
 sub moverand{
   
    my $n;
    my $ti;
    my $pre=0;
   
    for($ti=0;$ti<$dif;$ti++){
      
      $n=int(rand()*10);
      if($n==9||$n==$pre){next;}
      move($button[$n],int($n/3)+1,($n%3)+1);
      $pre=$n;
    }
   
	$countzz=0;
   
    return;
   
 }
 
 sub OnInit {
   
   for($i=0;$i<5;$i=$i+1)
   {
     for($j=0;$j<5;$j=$j+1)
     {
       $a[$i][$j]=-1;
     }
   }
   
   for($i=1;$i<4;$i=$i+1)
   {
     for($j=1;$j<4;$j=$j+1)
     {
       $a[$i][$j]=1;
     }
   }
   
   $a[3][3]=0;
   $k=0;
   
   for($i=1;$i<4;$i=$i+1)
   {
     for($j=1;$j<4;$j=$j+1)
     {
       $v[$i][$j]=$k;
       $k++;
     }
   }
   
   
   
   my $self = shift;
 
   my $frame = wxPerl::Frame->new(undef, 'A Sliding Puzzle');
   $frame->SetSize([600,600]);
   my $sizer = Wx::GridSizer->new(3,3);
   
   for($i=0;$i<9;$i++){
     $button[$i] = wxPerl::Button->new($frame,$i+1);
   }
   
   $button[8]->SetLabel('');
   $button[8]->Disable;
   
   #my $col = Wx::Colour->new('#ffeeee');
   
   
   for($i=0;$i<9;$i++){
     $sizer->Add($button[$i], 1, &Wx::wxEXPAND);
     #$button[$i]->SetBackgroundColour($col);
   }
   
   
   
   #button Events
   
   Wx::Event::EVT_BUTTON($button[0], -1, sub {
     my ($b, $evt) = @_;
     move($b,1,1);
   });  
   
   Wx::Event::EVT_BUTTON($button[1], -1, sub {
     my ($b, $evt) = @_;
     move($b,1,2);
   }); 
   
   Wx::Event::EVT_BUTTON($button[2], -1, sub {
     my ($b, $evt) = @_;
     move($b,1,3);
   }); 
   
   Wx::Event::EVT_BUTTON($button[3], -1, sub {
     my ($b, $evt) = @_;
     move($b,2,1);
   }); 
   
   Wx::Event::EVT_BUTTON($button[4], -1, sub {
     my ($b, $evt) = @_;
     move($b,2,2);
   }); 
   
   Wx::Event::EVT_BUTTON($button[5], -1, sub {
     my ($b, $evt) = @_;
     move($b,2,3);
   }); 
   
   Wx::Event::EVT_BUTTON($button[6], -1, sub {
     my ($b, $evt) = @_;
     move($b,3,1);
   }); 
   
   Wx::Event::EVT_BUTTON($button[7], -1, sub {
     my ($b, $evt) = @_;
     move($b,3,2);
   }); 
   
   Wx::Event::EVT_BUTTON($button[8], -1, sub {
     my ($b, $evt) = @_;
     move($b,3,3);
   }); 
   
   
   #moving random
   moverand();
 
   $frame->SetSizer($sizer);
   $frame->Show;
   
   
   
   
 }
 
 MyApp->new->MainLoop;