use strict;
use Dancer;

get '/hello' => sub {
    return $ENV{WORLD} || 'world';
};

dance;
