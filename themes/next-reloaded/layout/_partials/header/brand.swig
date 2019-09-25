<div class="site-brand-container">
  <div class="site-meta{%- if theme.custom_logo %} custom-logo{%- endif %}">
    {%- if theme.custom_logo and theme.scheme === 'Muse' %}
      <div class="site-meta-headline">
        <a>
          <img class="custom-logo-image" src="{{ theme.custom_logo }}" alt="{{ title }}">
        </a>
      </div>
    {%- endif %}
     
    <div>
      <a href="{{ config.root }}" class="brand" rel="start">

      <div class="logo-pics-udf" style=" position: absolute; height: auto; width: 56.5px;">
      <img src="https://picsshine.oss-cn-shenzhen.aliyuncs.com/blogpics/%E7%A8%BF%E5%AE%9A%E8%AE%BE%E8%AE%A1%E5%AF%BC%E5%87%BA-20190925-11028%20%281%29.png?Expires=1569391169&OSSAccessKeyId=TMP.hXFrN52gNpdo8GtBRFBf3EHRNUKTCreotetjcvSEdyKSPzfpzLphNN5nJTdkgSd3frbr2rsShW6neL6rTNjwdbjiuM8raH29LPbMf4AgTjS4BLrRkdxRAGArpKtv1p.tmp&Signature=MIURASPrmTpJIK5zGEwF0nhZY60%3D"/></div>
        <span class="logo-line-before"><i></i></span>
        <span class="site-title">{{ title }}</span>
        <span class="logo-line-after"><i></i></span>
      </a>
    </div>
    {%- if subtitle %}
      {%- if theme.seo %}
        <h1 class="site-subtitle" itemprop="description">{{ subtitle }}</h1>
      {% else %}
        <p class="site-subtitle">{{ subtitle }}</p>
      {%- endif %}
    {%- endif %}
    {%- if theme.custom_logo and (theme.scheme === 'Gemini' or theme.scheme === 'Pisces') %}
      <a>
        <img class="custom-logo-image" src="{{ theme.custom_logo }}" alt="{{ title }}">
      </a>
    {%- endif %}
  </div>

  <div class="site-nav-toggle">
    <button aria-label="{{ __('accessibility.nav_toggle') }}">
      <span class="btn-bar"></span>
      <span class="btn-bar"></span>
      <span class="btn-bar"></span>
    </button>
  </div>
</div>
