# Integració de Javascript i Symfony 

Junt al _bundle_ Encore s'instal·la suport per a Stimulus, un _framework_ 
lleuger JavaScript que fa fàcil adjuntar comportament a HTML. A més Symfony
 inclou paquets per afegir més característiques a Stimulus. 

El propòsit del fitxer `assets/bootstrap.js` és inicialitzar Stimulus i carregar 
automàticament qualsevol "controlador" del directori `assets/controllers/`.

## Cas d'ús: fer m'agrada

L'objectiu és implementar la funcionalitat de **M'agrada** amb Javascript, usant
el mètode `fetch`.

Primerament crearem una interacció simple en què en fer **M'agrada** s'incrementarà
el comptador de _likes_.

### Pas 1: Controlador stimulus

El següent codi afig un esdeveniment que en fer clic sobre l'element
associat incrementa el comptador  de _likes_ i l'escriu en el  _target_ `count`.

```javascript 
import { Controller } from '@hotwired/stimulus';
/*
* The following line makes this controller "lazy": it won't be downloaded until needed
* See https://github.com/symfony/stimulus-bridge#lazy-controllers
*/
/* stimulusFetch: 'lazy' */
export default class extends Controller {
    static targets = ['count']

    connect() {
        this.count = 0;
        this.element.addEventListener('click', (event) => {
            this.count++;
            this.countTarget.innerText = this.count;
            event.preventDefault();
        });
    }
    // ...
}
```

L'array `targets` inclou els elements vàlids sobre els quals volem actuar i 
el mètode `connect()` s'executa automàticament quan s'assigna el controlador
a qualsevol element.

### Pas 2: Adaptació de la vista

Afegirem els atributs `data-controler` amb el nom del controlador i `data-like-target` amb el nom
amb què volem identificar l'element que modificarem des del controlador, `count` en l'exemple.

```html+twig hl_lines="1 7"
<div data-controller="like" class="pe-5">
{%  if app.user not in truit.linkingUsers  %}
    <a title="M'agrada" href="{{ path('tweet_like', { id: truit.id }) }}"><i class="bi bi-heart"></i></a>
{% else %}
    <i class="text-danger bi bi-heart-fill"></i>
{% endif %}
<span data-like-target="count" class="ms-1">{{ truit.likeCount }}</span>
</div>
```        

### Pas 3. Creació de l'_endpoint_

Farem una versió del mètode `like` que en lloc de fer una redirecció retornarà
una resposta en format JSON.

```php
#[Route('/api/tweets/{id}/like', name: 'api_tweet_like')]
    public function apiLike(Tweet $tweet, TweetRepository $tweetRepository): Response {

        $user = $this->getUser();

        if (!$user)
            return new JsonResponse(["result"=>"ko"], Response::HTTP_UNAUTHORIZED);

        if ($tweet->getLinkingUsers()->contains($user))
            return new JsonResponse(["result"=>"ko"], Response::HTTP_OK);

        $tweet->addLinkingUser($user);
        $tweet->setLikeCount($tweet->getLikeCount() + 1);
        $tweetRepository->save($tweet, true);

        return new JsonResponse(["result"=>"ok"], Response::HTTP_OK);
    }
```

### Pas 4: Adaptació de la vista 

Afegirem l'atribut `data-like-url-value` amb la URL de l'_endpoint_ i un nou _target_
anomenat `icon`, aquest ens permetrà modificar la icona.

```html+twig hl_lines="2 3"
<div data-controller="like" 
    data-like-url-value="{{ path('api_tweet_like', { id: truit.id }) }}" class="pe-5">
    {%  if app.user not in truit.linkingUsers  %}
        <a title="M'agrada" data-like-target="icon" href="{{ path('tweet_like', { id: truit.id }) }}"><i class="bi bi-heart"></i></a>
    {% else %}
        <i class="text-danger bi bi-heart-fill"></i>
    {% endif %}
    <span data-like-target="count" class="ms-1">{{ truit.likeCount }}</span>
</div>
```

### Pas 5: Versió final del controlador

```javascript
import { Controller } from '@hotwired/stimulus';
/*
* The following line makes this controller "lazy": it won't be downloaded until needed
* See https://github.com/symfony/stimulus-bridge#lazy-controllers
*/
/* stimulusFetch: 'lazy' */
export default class extends Controller {
    static targets = ['count', 'icon']
    static values = {
        url: String,
    }
    connect() {
        this.count = 0;
        this.element.addEventListener('click', (event) => {
            this.load();
            event.preventDefault();
            console.log(this.urlValue);
        });
    }

    load() {
        fetch(this.urlValue)
            .then(response => response.json())
            .then(data => this.update(data))
    }

    update(data) {
        if (data.result === "ok") {
            this.count++;
            this.countTarget.innerText = this.count;
            this.iconTarget.innerHTML = "<i class=\"text-danger bi bi-heart-fill\"></i>";
        }
    }
    // ...
}
```

## Recursos

<https://symfony.com/doc/current/frontend/encore/simple-example.html#stimulus-symfony-ux>
<https://symfonycasts.com/screencast/stimulus/properties-events>
<https://stimulus.hotwired.dev/>