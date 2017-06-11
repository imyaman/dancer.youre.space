#!/usr/bin/env perl


use utf8;
use Dancer2;

binmode STDOUT, ':encoding(UTF-8)';

set serializer => 'JSON';
set charset => 'UTF-8';
set logger => 'console';
set log => 'debug';
set show_errors => 1;
set startup_info => 1;

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
    return { time => $t };
    #return { time => "hello" };
};

get '/integer/:a/plus/:b' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my ($a, $b, $s);
    $a = route_parameters->get('a');
    $b = route_parameters->get('b');
    $s = $a + $b;
    return { sum => "$s " };
    #return { sum => "32" };
};

dance;
