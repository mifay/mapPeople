#!/usr/bin/perl

# Copyright 2016 Michael Fayad
#
# This file is part of mapPeople.
#
# This file is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This file is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this file.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use warnings;

open RedacteurDeFichier,">output.kml" or die $!;
my $debutKML = '<?xml version="1.0" encoding="UTF-8"?> <kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom"> <Document> 	<name>Membres.kml</name> 	<StyleMap id="m_ylw-pushpin"> 		<Pair> 			<key>normal</key> 			<styleUrl>#s_ylw-pushpin</styleUrl> 		</Pair> 		<Pair> 			<key>highlight</key> 			<styleUrl>#s_ylw-pushpin_hl</styleUrl> 		</Pair> 	</StyleMap> 	<Style id="s_ylw-pushpin_hl"> 		<IconStyle> 			<color>ff00aa00</color> 			<scale>1.3</scale> 			<Icon> 				<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href> 			</Icon> 			<hotSpot x="20" y="2" xunits="pixels" yunits="pixels"/> 		</IconStyle> 		<LabelStyle> 		</LabelStyle> 	</Style> 	<Style id="s_ylw-pushpin"> 		<IconStyle> 			<color>ff00aa00</color> 			<scale>1.1</scale> 			<Icon> 				<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href> 			</Icon> 			<hotSpot x="20" y="2" xunits="pixels" yunits="pixels"/> 		</IconStyle> 		<LabelStyle> 		</LabelStyle> 	</Style> 	<Folder> 		<name>Membres</name> 		<open>1</open>';
print RedacteurDeFichier $debutKML;

# Placemark KML
my $pmKML1 = '		<Placemark> 			<name>';
my $pmKML2 = '</name> 			<description>';
my $pmKML3 = '</description> 			<LookAt> 				<longitude>-73.70709300002088</longitude> 				<latitude>45.52247700002031</latitude> 				<altitude>0</altitude> 				<heading>-1.492157228808609e-011</heading> 				<tilt>0</tilt> 				<range>1000.000080507214</range> 				<gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode> 			</LookAt> 			<styleUrl>#m_ylw-pushpin</styleUrl> 			<Point> 				<coordinates>';
my $pmKML4 = '</coordinates> 			</Point> 		</Placemark>';

open LecteurDeFichier,"<input.txt" or die "E/S : $!\n";
while (my $Ligne = <LecteurDeFichier>)
{
	print "reading\n";
   if($Ligne =~ /^(.+);(.+);(.+);(.+);(.+);(.+);(.*);(.*);(.*);(.*);(.*);(.+)$/)
   {
		print "reading: $Ligne\n";
        my $nom = $1;# Nom
        my $typeMem = $2;# Type de membership
        my $dateExp = $3;# Date d'expiration du membership
        my $dateAdh = $4;# Date d'adhésion au parti
        my $statMem = $5;# Statut du membership
        my $adr = $6;# Adresse postale
        my $ville = $7;#  Ville
        my $codePost = $8;# Code postal
        my $courriel = $9;# Courriel
        my $tel = $10;# Téléphone
        my $lat = $11; # latitude
        my $lng = $12; # longitude
        
        $Ligne =~ s/;/\n/g; # search and replace all ";" for \n for cuter display
        
        print RedacteurDeFichier "$pmKML1\n$statMem\n$pmKML2\n$Ligne\n$pmKML3\n$lng,$lat,0\n$pmKML4\n\n";
   }
}
close LecteurDeFichier;

my $finKML = '</Folder> </Document> </kml>';
print RedacteurDeFichier $finKML;
close RedacteurDeFichier;
