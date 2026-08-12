# Plan de Migración SEO-Seguro — slingshotmia.com

**Origen:** GoDaddy Website Builder 8.0 · **Destino:** Sitio estático propio (Vercel) · **Incluye:** sitio + transferencia de dominio

---

## 1. Inventario del sitio actual (lo que hay que preservar EXACTO)

### URLs indexables

| URL | Title actual | Meta description |
|---|---|---|
| `/` | Slingshot Rentals Miami & South Beach \| #1 Polaris Slingshot Rental | Rent a Polaris Slingshot in Miami Beach from $100/hr or $300/day. Delivery available in Miami Dade & Broward County. Book online or call +1 786 694 4178! |
| `/jet-ski-rentals-miami` | Jet Ski Rentals Miami \| Haulover Park & Sunny Isles Beach | Rent jet skis near Sunny Isles Beach & Haulover Park in Miami. Book 1, 2, or 3-hour rentals and explore beautiful Biscayne Bay. Reserve your jet ski today! |
| `/6-seaters-slingshot-miami` | 6 Seaters Slingshot Rental Miami \| Group & Family Rides | Rent a 6-seater Polaris Slingshot in Miami Beach — perfect for groups & families. Enjoy an open-air ride along the coast. Book your slingshot today! |
| `/miami-slingshot-rentals` | Miami Slingshot Rentals \| Affordable Polaris Slingshot Rides | Affordable Polaris Slingshot rentals in Miami Beach. Enjoy a thrilling 3-wheel open-air experience with delivery included. Book hourly or 24-hour rides today! |
| `/about` | About Slingshot Rentals Miami \| South Beach Polaris Slingshot | Slingshot Rentals Miami serves South Florida with Polaris Slingshot rentals. We deliver to Miami Dade & Broward County. Ask about our daily specials! |
| `/boat-rentals` | Boat Rentals Miami \| Captain & Fuel Included \| Book Instantly | (página con contenido embebido) |
| `/book` | (página de booking, casi vacía — verificar si está indexada) | — |

### Activos técnicos a replicar

- **Google Tag Manager:** `GTM-N5PHWHNF` (instalar el MISMO contenedor en el sitio nuevo — conserva Analytics sin tocar nada)
- **Google site verification:** meta tag `nWl_xSdiFm5xMkSoZOf1muYrUNeDx3DaMyvsF0ODqfA` (mantener acceso a Search Console)
- **Booking:** enlaces a FareHarbor (`fareharbor.com/embeds/book/miamistylerentals/...`) — slingshot item 339925, jetski item 326919, 6-seater item 591231
- **Imágenes:** alojadas en `img1.wsimg.com` (CDN de GoDaddy) — **descargar TODAS antes de cancelar GoDaddy**, porque desaparecerán
- **Datos NAP (críticos para SEO local):** 1550 NE 168th St North Miami Beach FL 33162 · (786) 694-4178 · jetski: 3000 NE 151st St North Miami FL 33181
- **Redes:** Facebook, Instagram @slingshots_rentals, YouTube @Slingshotmia
- **Formulario de contacto** (reCAPTCHA) y **widget de reviews** — replicar con alternativas

---

## 2. Principios para no perder SEO

1. **Mismas URLs, ruta por ruta.** `/jet-ski-rentals-miami` debe seguir siendo `/jet-ski-rentals-miami`. Cero cambios = cero redirects necesarios = cero pérdida.
2. **Mismos titles, metas, H1s y contenido** en el lanzamiento. Mejoras de contenido DESPUÉS, una vez estabilizado (4-6 semanas).
3. **El dominio nunca cambia**, solo apunta a otro servidor. Google no penaliza cambios de hosting.
4. **Versión www vs no-www:** mantener `https://slingshotmia.com` como canónica con redirect 301 desde www.
5. **No tocar Google Business Profile** — solo verificar que el sitio enlazado siga funcionando tras el cambio.

---

## 3. Fases

### Fase A — Preparación (sin riesgo, el sitio actual sigue vivo)
- [ ] Verificar propiedad en **Google Search Console** (si no está ya) y exportar: páginas indexadas, queries principales, backlinks
- [ ] Descargar todas las imágenes de `img1.wsimg.com`
- [ ] Construir el sitio nuevo (estático, mismas URLs/metas/contenido) y desplegarlo en Vercel con URL temporal (`*.vercel.app`) **con `noindex` temporal**
- [ ] Añadir: sitemap.xml, robots.txt, schema.org `LocalBusiness` + `FAQPage` (mejora vs. el sitio actual)
- [ ] Probar todo: enlaces FareHarbor, formulario, móvil, velocidad

### Fase B — Cutover de DNS (el momento clave, ~1 hora de trabajo)
- [ ] Bajar el TTL del registro A/CNAME en GoDaddy a 600s (1 día antes)
- [ ] Quitar el `noindex` del sitio nuevo
- [ ] En GoDaddy DNS: apuntar `@` y `www` a Vercel (A `76.76.21.21` / CNAME según indique Vercel)
- [ ] Verificar SSL activo en Vercel para el dominio
- [ ] Comprobar que TODAS las URLs viejas cargan idénticas (status 200)
- [ ] **NO cancelar el plan de Website Builder todavía** (rollback disponible 1-2 semanas)

### Fase C — Post-lanzamiento (días 1-14)
- [ ] Search Console: solicitar indexación de cada URL, enviar sitemap nuevo
- [ ] Vigilar Cobertura/Indexación en Search Console a diario la primera semana
- [ ] Verificar que GTM/Analytics registra tráfico normal
- [ ] Test de velocidad (PageSpeed Insights) — debería mejorar mucho vs. GoDaddy Builder

### Fase D — Transferencia del dominio (después del cutover, sin prisa)
> La transferencia del registro NO afecta SEO. Se hace al final para no mezclar variables.
- [ ] En GoDaddy: desbloquear dominio + obtener código EPP/auth
- [ ] Verificar que el dominio tenga +60 días desde registro/última transferencia
- [ ] Iniciar transferencia en el nuevo registrador (Cloudflare ~costo, Porkbun, Namecheap)
- [ ] **Antes de transferir:** copiar TODOS los registros DNS (incluidos MX si hay email)
- [ ] Confirmar email de transferencia (tarda 5-7 días)
- [ ] Al completar: verificar DNS intacto y sitio funcionando
- [ ] Recién entonces: cancelar Website Builder en GoDaddy

---

## 4. Riesgos y mitigación

| Riesgo | Mitigación |
|---|---|
| URLs nuevas no idénticas | Checklist de URLs 1:1 antes del cutover |
| Imágenes rotas (CDN GoDaddy) | Descargar y autoalojar todo antes |
| Email @slingshotmia.com roto | Copiar registros MX antes de tocar DNS |
| Caída durante cambio DNS | TTL bajo + GoDaddy sigue sirviendo hasta propagación |
| Algo sale mal | GoDaddy Builder activo 2 semanas = rollback en minutos |

---

## 5. Mantenimiento futuro sin código

El sitio cambia poco (precios, FAQ). Opciones: pedirme los cambios aquí en Cowork (edito y redespliego en minutos), o conectar un CMS simple más adelante si quieres editar tú directamente.
