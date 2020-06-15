<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns="http://www.w3.org/1999/xhtml">

  <xsl:output method="html"/>

  <xsl:variable name="titolo" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>

  <xsl:variable name="autori" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:name"/>

  <xsl:variable name="luogo" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:publisher"/>

  <xsl:variable name="data" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:date"/>

  <xsl:variable name="titoloSrc" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:title"/>

  <xsl:variable name="autoreSrc" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:author"/>

  <xsl:variable name="dataSrc" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:date"/>

  <xsl:variable name="publisherSrc" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:publisher"/>

  <xsl:variable name="Retro" select="/tei:TEI/tei:facsimile/tei:surface[@type='retro']/tei:graphic/@url"/>

  <xsl:variable name="Fronte" select="/tei:TEI/tei:facsimile/tei:surface[@type='fronte']/tei:graphic/@url"/>

  <xsl:variable name="postcard" select="//tei:div[@type='postcard']"/>

  <xsl:template match="/tei:TEI">
    <html>
      <head>
        <title>
          <xsl:value-of select="$titolo"/>
        </title>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/maphilight/1.4.0/jquery.maphilight.min.js"></script>

        <script src="postcard_tei.js"></script>
        <link rel="stylesheet" type="text/css" href="postcard_tei.css"></link>
      </head>
      <body>

        <div id="content">

          <div id="headerData" class="containerL">
            <h4>
              Intestazione:
            </h4>
            <br></br>
            <ul>
              <li class="heading"><xsl:value-of select="$titolo"/></li>
              <li class="heading">
                Codifica di:

                <xsl:value-of select="$autori"/></li>
              <li class="heading">

                <xsl:value-of select="$luogo"/>
                in data

                <xsl:value-of select="$data"/></li>
              <li class="heading">
                Documento:

                <xsl:value-of select="$titoloSrc"/>
                del

                <xsl:value-of select="$dataSrc"/></li>
              <li class="heading">
                Autore:

                <xsl:value-of select="$autoreSrc"/></li>

            </ul>
            <ul>
              <li class="heading">Luoghi:</li>

              <xsl:apply-templates select="//tei:place"/>
            </ul>
            <ul>
              <li class="heading">Persone:</li>

              <xsl:apply-templates select="//tei:person/tei:persName"/>
            </ul>
          </div>

          <div id="cover" class="containerL">
            <h4>
              Fronte cartolina:
            </h4>
            <br></br>
            <!-- <h4> </h4> <h5> <xsl:value-of select="//figure/head"/> </h5> <p> <xsl:value-of select="//figure/figDesc"/> </p> -->

            <xsl:apply-templates select="//tei:front"/>

          </div>

          <div id="transcription" class="containerL">
            <h4>
              Autore:

              <xsl:value-of select="$autoreSrc"/>
              Datazione:

              <xsl:value-of select="$dataSrc"/>
            </h4>
            <br></br>

            <xsl:for-each select="$postcard/tei:div/@type">

              <!-- <h5 name="{current()}" id="INDEX{current()}" > <xsl:value-of select="."/> </h5> -->
              <p>
                <div class="areas" id="DIV{current()}">

                  <xsl:for-each select="../tei:ab">
                    <xsl:apply-templates select="."/>
                  </xsl:for-each>
                </div>
              </p>

            </xsl:for-each>

          </div>

          <div id="graphics" class="containerR">

            <xsl:for-each select="/tei:TEI/tei:facsimile/tei:surface">
              <div class="surface" id="grafica_{current()/@type}">
                <ul>
                  <li>
                    <h5>
                      <xsl:value-of select="current()/@type"/>
                    </h5>
                  </li>
                </ul>

                <xsl:apply-templates select="current()/tei:graphic"/>
                <map name="{current()/@type}_MAP">
                  <xsl:apply-templates select="current()/tei:zone"/>
                </map>
              </div>
            </xsl:for-each>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="//tei:stamp">
    <div class="stamp">

      <xsl:choose>

        <xsl:when test="@xml:lang">
          [<xsl:value-of select="@xml:lang"/>Traduzione]
          <xsl:apply-templates select="*|node()"/>
        </xsl:when>

        <xsl:when test="@type='postmark'">
          <br></br>
          <div class="francobollo">

            <xsl:apply-templates select="*|node()"/>

          </div>
        </xsl:when>

        <xsl:when test="@type='postage'">
          <br></br>
          <div class="timbro_postale">

            <xsl:apply-templates select="*|node()"/>

          </div>
        </xsl:when>

        <xsl:otherwise>

          <xsl:apply-templates select="*|node()"/>

        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <xsl:template match="//tei:place/tei:desc">
    <div class="luogo tooltip">

      <xsl:apply-templates select="*|node()"/>

    </div>
  </xsl:template>

  <xsl:template match="//tei:name">
    <div class="nome tooltip">

      <xsl:apply-templates select="*|node()"/>

    </div>
  </xsl:template>

  <xsl:template match="//tei:addrLine">
    <div class="lineaIndirizzo">
      <xsl:apply-templates select="*|node()"/>
    </div>
    <br></br>
  </xsl:template>

  <xsl:template match="//tei:address">

    <br></br>
    <div class="indirizzo">
      <xsl:apply-templates select="*|node()"/>
    </div>

  </xsl:template>

  <xsl:template match="//tei:unclear">
    <div class="pocoChiaro">
      <xsl:apply-templates select="*|node()"/>
    </div>
  </xsl:template>

  <xsl:template match="//tei:abbr">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="//tei:expan">
    <div class="espansione tooltip">
      <xsl:value-of select="."/>
    </div>
  </xsl:template>

  <xsl:template match="//tei:num">
    <div class="numero tooltip">

      <xsl:apply-templates select="*|node()"/>

    </div>
  </xsl:template>

  <xsl:template match="//tei:mentioned">
    <div class="menzione tooltip">

      <xsl:apply-templates select="*|node()"/>

    </div>
  </xsl:template>

  <xsl:template match="//tei:note">

    <xsl:choose>

      <xsl:when test="@type='handnote'">

        <div class="notaAMano">
          <xsl:apply-templates select="*|node()"/>

        </div>

      </xsl:when>

      <xsl:otherwise>
        <div class="nota">
          <xsl:apply-templates select="*|node()"/>
        </div>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="//tei:gap">
    <div class="mancanza">
      <xsl:apply-templates select="*|node()"/>
    </div>
  </xsl:template>

  <xsl:template match="//tei:date">
    <div class="data tooltip" datazione="{@when}">

      <xsl:apply-templates select="*|node()"/>

    </div>
  </xsl:template>

  <xsl:template match="//tei:div/@facs">
    <div class="areas">

      <xsl:apply-templates select="*|node()"/>

    </div>
  </xsl:template>

  <xsl:template match="//tei:zone">
    <area id="{current()/@xml:id}" shape="poly" coords="{translate(@points,' ',',')}" onclick="creaToolTip('#DIV{current()/@xml:id}')"></area>
    <script>
      $(function () {
        $('#<xsl:value-of select="@xml:id"/>').hover(function () {
          $('#DIV<xsl:value-of select="@xml:id"/>').css('background-color', '#6b6b66');
        }, function () {
          $('#DIV<xsl:value-of select="@xml:id"/>').css('background-color', '');
        });
      });
      $(function () {
        $('#DIV<xsl:value-of select="@xml:id"/>').hover(function () {
          $('#DIV<xsl:value-of select="@xml:id"/>').css('background-color', '#6b6b66');
          $('#<xsl:value-of select="@xml:id"/>').mouseenter();
        }, function () {
          $('#DIV<xsl:value-of select="@xml:id"/>').css('background-color', '');
          $('#<xsl:value-of select="@xml:id"/>').mouseout();
        });
      });
    </script>
  </xsl:template>

  <xsl:template match="//tei:graphic">
    <img src="{current()/@url}" width="{substring-before(@width,'px')}" height="{substring-before(@height,'px')}" id="IMG_{../@xml:id}" usemap="#{../@xml:id}_MAP" class="map"></img>
  </xsl:template>

  <xsl:template match="//tei:ab">
    <div class="blocco">

      <xsl:choose>

        <xsl:when test="@facs">
          <br></br>
          <div id="DIV{current()/@facs}" class="{current()/@type}">
            <xsl:apply-templates select="*|node()"/>
          </div>
        </xsl:when>

        <xsl:when test="@type='description'">
          <br></br>
          <div class="descrizione_fronte">

            <xsl:apply-templates select="*|node()"/>

          </div>
        </xsl:when>

        <xsl:when test="@type='copyright'">

          <xsl:apply-templates select="*|node()"/>

        </xsl:when>

        <xsl:when test="@type='message'">
          <br></br>

          <xsl:apply-templates select="*|node()"/>

        </xsl:when>

        <xsl:otherwise>
          <xsl:apply-templates select="*|node()"/>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <xsl:template match="//tei:lb">
    <br></br>
  </xsl:template>

  <xsl:template match="//tei:choice" name="choice">

    <xsl:apply-templates select="current()/tei:abbr"/>

  </xsl:template>

  <xsl:template match="//tei:desc">
    <div class="desc">
      <xsl:apply-templates select="*|node()"/>
    </div>
  </xsl:template>

  <xsl:template match="//tei:figure[@facs='front_figure']">
    <div id="DIV{current()/@facs}">
      <h5>
        <xsl:value-of select="//tei:figure/tei:head"/>
      </h5>
      <p>
        <xsl:value-of select="//tei:figure/tei:figDesc"/>
      </p>
    </div>
  </xsl:template>

  <xsl:template match="//tei:figure[@facs='artist_signature']">
    <div id="DIV{current()/@facs}">
      <h5>
        Autore:
      </h5>
      <p>
        <xsl:value-of select="//tei:figure/tei:signed"/>
      </p>
    </div>
  </xsl:template>

  <xsl:template match="//tei:front/tei:ab[@facs='dedica_fronte']">
    <div id="DIV{current()/@facs}">
      <h5>
        Dedica:
      </h5>
      <p>
        <xsl:value-of select="//tei:front/tei:ab"/>
      </p>
    </div>
  </xsl:template>

  <xsl:template match="//tei:placeName">
    <li>
      <div class="collegamento">
        <a href="{current()/@ref}" target="_blank"><xsl:apply-templates select="*|node()"/></a>

      </div>
    </li>
  </xsl:template>

  <xsl:template match="//tei:persName">
    <li>

      <xsl:choose>

        <xsl:when test="@ref">

          <div class="collegamento">
            <a href="{current()/@ref}" target="_blank"><xsl:apply-templates select="*|node()"/></a>

          </div>

        </xsl:when>

        <xsl:otherwise>
          <xsl:apply-templates select="*|node()"/>
        </xsl:otherwise>
      </xsl:choose>
    </li>
  </xsl:template>

</xsl:stylesheet>
