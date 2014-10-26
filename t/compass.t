use t::Helper;
use File::Which;

plan skip_all => 'Need to install sass+compass' unless which 'compass';

{
  diag "minify=0";
  my $t = t::Helper->t({ minify => 1 });

  plan skip_all => 'Could not find preprocessors for scss', 6 unless $t->app->asset->preprocessors->has_subscribers('scss');

  $t->app->asset('compass.css' => '/sass/compass.scss');
  $t->get_ok('/compass')->status_is(200);
  $t->get_ok($t->tx->res->dom->at('link')->{href})->status_is(200)->content_like(qr{\babcdef\b});
}

done_testing;

__DATA__
@@ compass.html.ep
%= asset 'compass.css'
