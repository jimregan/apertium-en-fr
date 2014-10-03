#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode STDIN, ":utf8";
open(FR, ">", "fr.tmp") or die $!;
open(ENFR, ">", "en-fr.tmp") or die $!;
binmode FR, ":utf8";
binmode ENFR, ":utf8";

my %gender = (
	"/empereur__n" => "GD",
	"/oeil__n" => "m",
	"ATS__n" => "mf",
	"BBC__n" => "f",
	"OPA__n" => "f",
	"BBVA__n" => "m",
	"IRPF__n" => "m",
	"abeille__n" => "f",
	"abords__n" => "m",
	"administrat/eur__n" => "GD",
	"addend/um__n" => "m",
	"doct/eur__n" => "GD",
	"admis__n" => "GD",
	"pakistanais__n" => "GD",
	"affecté__n" => "GD",
	"duc__n" => "GD",
	"ancien__n" => "GD",
	"anima/l__n" => "m",
	"argent__n" => "m",
	"artiste__n" => "mf",
	"bouch/er__n" => "GD",
	"boucle/_d'oreille__n" => "f",
	"brand/y__n" => "m",
	"buffle__n" => "d",
	"causeu/r__n" => "GD",
	"chat__n" => "GD",
	"cie/l__n" => "m",
	"clown__n" => "GD",
	"colonel__n" => "GD",
	"commercia/l__n" => "GD",
	"compte/_rendu__n" => "m",
	"conférence/_de_presse__n" => "f",
	"d/ieu__n" => "GD",
	"débit/eur__n" => "GD",
	"eau__n" => "f",
	"ex__n" => "mf",
	"fil/s__n" => "GD",
	"fois__n" => "f",
	"fra/is__n" => "GD",
	"grec__n" => "GD",
	"héro/s__n" => "GD",
	"jui/f__n" => "GD",
	"lieu__n" => "m",
	"livre__n" => "m",
	"flash__n" => "m",
	"m/onsieur__n" => "GD",
	"match__n" => "m",
	"mois__n" => "m",
	"personnel__n" => "m",
	"soif__n" => "f",
	"po/ète__n" => "GD",
	"r/oi__n" => "GD",
	"serv/iteur__n" => "GD",
	"trava/il__n" => "m",
	"tur/c__n" => "GD",
	"vacances__n" => "f",
	"alma_mater__n" => "f",
	"vende/ur__n" => "GD",
	"vie/ux__n" => "GD",
	"vitra/il__n" => "m",
	"à_il__n" => "GD",
	"épou/x__n" => "GD"
);

my $last = '';

while (<>) {
	chomp;
	my @entry = split/\t/;
	my $en = trim($entry[0]);
	my $r = '';
	if ($last eq $en) {
		$r = ' r="RL"';
	} else {
		$r = '';
	}
	$last = $en;
	my $fr = trim($entry[1]);
	my $paradigm = '';
	if($#entry > 1) {
		$paradigm = trim($entry[2]);
	} else {
		if ($en =~ /ism$/ && $fr =~ /sme$/) {
			$paradigm = 'livre__n';
		} elsif (($en =~ /ist$/ && $fr =~ /iste$/) || ($en =~ /ogist$/ && $fr =~ /ogue$/) || ($en =~ /amist$/ && $fr =~ /ame$/) || ($en =~ /odist$/ && $fr =~ /ode$/)
                        || ($en =~ /matist$/ && $fr =~ /mate$/)) {
			$paradigm = 'artiste__n';
		} else {
			print STDERR "Missing paradigm: ($en, $fr)\n";
			next;
		}
	}
	my $gen = $gender{$paradigm};
	if ($gen ne 'GD') {
		print ENFR "    <e$r><p><l>$en<s n=\"n\"/></l><r>$fr<s n=\"n\"/><s n=\"$gen\"/></r></p></e>\n";
	} else {
		print ENFR "    <e r=\"LR\"><p><l>$en<s n=\"n\"/></l><r>$fr<s n=\"n\"/><s n=\"$gen\"/></r></p></e>\n";
		print ENFR "    <e r=\"RL\"><p><l>$en<s n=\"n\"/></l><r>$fr<s n=\"n\"/></r></p></e>\n";
	}
	my $stem = stem($paradigm, $fr);
	print FR "    <e lm=\"$fr\"><i>$stem</i><par n=\"$paradigm\"/></e>\n";
}

sub trim {
	my $in = $_[0];
	$in =~ s/^ //;
	$in =~ s/ $//;
	$in =~ s/\n//;
	$in;
}

sub stem {
	my $p = $_[0];
	my $w = $_[1];
	$p =~ s/__n$//;
	my $stem = '';
	if ($p =~ m!/!) {
		my @tmp = split(/\//, $p);
		my $stem = $tmp[1];
		my $re = $stem . '$';
		$w =~ s/$re//;
		return $w;
	} else {
		return $w;
	}
}
