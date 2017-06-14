#!/usr/bin/env perl


use utf8;
use Dancer2;
use lib 'lib'

binmode STDOUT, ':encoding(UTF-8)';

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

get '/api/myenv' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my ($myenv, $key);
    for $key (keys %ENV){
      $myenv .= $key . " : " . $ENV{$key} . "    " ;
    }
    return { myenv => $myenv };
};

get '/api/allenv' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my ($string, $key);
    for $key (keys request->env()){
      $string .= "\"$key\"" . ":" .  request->env->{$key} . "    <br>\n";
    }
    return { $string };
};

get '/api/envinc' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my $myinc = join ',,,,', @INC;
    return { $ENV{PWD} => $myinc };
};

get '/integer/:a/plus/:b' => sub {
    headers 'Access-Control-Allow-Origin' => '*';
    my ($a, $b, $s);
    $a = route_parameters->get('a');
    $b = route_parameters->get('b');
    $s = $a + $b;
    return { sum => "$s" };
};

dance;
