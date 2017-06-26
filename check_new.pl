#!/usr/bin/perl 

open (AAA,">>date.txt");
$aaa = localtime();
print AAA $aaa;
 

$counter_date_name = "2017.06";

$counter_num_name = "counter2";

$dir_path = "/root/counter/*";


$select_date = "2017-06-21";

@files = glob( $dir_path );

@files_select = grep /$select_date/,@files;



foreach (@files_select){
  my $file_path = "$_";
  open(DATA1,"<$file_path");
  open(DATA2,">>line_select.log");
  my @line = <DATA1>;
  my @appid = qw/7nq0490JF49D2z2b7GPq J09wd5X6h0307VK4m7E6/;
  $appid_1 = "@appid[0]";
  $appid_2 = "@appid[1]";
  my @line_select_1 = grep m/\"$appid_1\"/i, @line;
  foreach (@line_select_1){
                print DATA2 "$_";
        }
  my @line_select_2 = grep m/\"$appid_2\"/i, @line;
  foreach (@line_select_2){
                print DATA2 "$_";
        }
  close ( DATA1 );
  close ( DATA2 );
}

@counter_id = qw/ad_adview ad_adshow ad_adloaded ad_adcomplete ad_adrandom/;
@adname = qw/adcolony applovin chance chartboost dianjoy domob facebook inmobi leadbolt mobvista nativex pingcoo uniplay unityads vungle admob centrixlink tapjoy/;
my %adname2 = (
"adcolony" => 4,
"applovin" => 6,
"chance" => 8, 
"chartboost" => 3, 
"dianjoy" => 11,
"domob" => 17, 
"facebook" => 15, 
"inmobi" => 13, 
"leadbolt" => 12,
"mobvista" => 18, 
"nativex" => 9,
"pingcoo" => 14, 
"uniplay" => 16, 
"unityads" => 5,
"vungle" => 2, 
"admob" => 21, 
"centrixlink" => 22, 
"tapjoy" => 23
);

use Switch;
open(DATA2,"<line_select.log");
open(DATA3,">>sum.log");
while (@line=<DATA2>) {
  foreach $counter (@counter_id){
    switch($counter){
      case "ad_adview" {
        foreach (@adname){
          $adname_alias = $adname2{"$_"};
          @counter_select = grep /$counter/,@line;
          @adname_counter_select = grep /platform\\\":\\\"$adname_alias/,@counter_select;
          $number = $#adname_counter_select;
          $number += 1;
          print DATA3 "$_,$adname_alias,$counter,$number\n";
        }
      }
      case "ad_adshow" {
        foreach (@adname){
          $adname_alias = $adname2{"$_"};
          @counter_select = grep /$counter/,@line;
          @adname_counter_select = grep /platform\\\":\\\"$adname_alias/,@counter_select;
          $number = $#adname_counter_select;
          $number += 1;
          print DATA3 "$_,$adname_alias,$counter,$number\n";
        }
      }
      else {
        foreach (@adname){
          @counter_select = grep /$counter/,@line;
          @adname_counter_select = grep /\\\"$_\\\"/,@counter_select;
          $number = $#adname_counter_select;
          $number += 1;
          print DATA3 "$_,$counter,$number\n";
        }
      }
    }
  }
}

$bbb = localtime();
print AAA $bbb;
close ( AAA );
close ( DATA2 );
close ( DATA3 );
