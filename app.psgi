#!/usr/bin/env perl

binmode STDOUT, ':encoding(UTF-8)';

use utf8;
use Dancer2;

get '/' => sub {
    template 'index';
};

get '/hello' => sub {
    return $ENV{WORLD} || 'world';
};

get '/api/time' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime();
    my $t = sprintf("%04d-%02d-%02dT%02d:%02d:%02dZ", $year+1900, $mon+1, $mday, $hour, $min, $sec);
    #return { time => $t };
    return { time => "hello" };
};

get '/integer/:a/plus/:b' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my ($a, $b, $s);
    $a = route_parameters->get('a');
    $b = route_parameters->get('b');
    $s = $a + $b;
    #return { sum => "$s " };
    return { sum => "32" };
};

dance;
