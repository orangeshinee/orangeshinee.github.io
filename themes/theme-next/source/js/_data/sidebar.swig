
{%- if theme.social %}
  <div class="links-of-author motion-element">
    {%- for name, link in theme.social %}
      <span class="links-of-author-item">
      {%- set sidebarURL = link.split('||')[0] | trim %}
      {%- if not (theme.social_icons.enable) or (not theme.social_icons.icons_only) %}
        {%- set sidebarText = name %}
      {%- endif %}
      {%- if theme.social_icons.enable %}
        {%- set sidebarIcon = '<svg class="icon aria-hidden="true"><use xlink:href="#' + link.split('||')[1] | trim | default('icon-zhizhuxia') + '"></use></svg>'  %}
      {%- endif %}
        {{ next_url(sidebarURL, sidebarIcon + sidebarText, {title: name + ' &rarr; ' + sidebarURL}) }}
      </span>
    {%- endfor %}
  </div>
{%- endif %}
