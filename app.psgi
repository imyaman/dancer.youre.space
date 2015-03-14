use strict;
use Dancer;

get '/' => sub {
    return $ENV{WORLD} || 'world';
};

get '/hello' => sub {
    return $ENV{WORLD} || 'world';
};

dance;
