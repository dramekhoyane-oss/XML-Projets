<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cab="http://www.univ-grenoble-alpes.fr/l3miage/medical">
    <xsl:output method="html" doctype-system="about:legacy-compat"/>

    <!-- point d'entrée de la transformation -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Cabinet Médical</title>
                <style>
                    body { font-family: Arial, sans-serif; background-color: #f4f7fa; color: #333; margin: 20px; }
                    h1 { color: #007bff; text-align: center; }
                    h2 { color: #0056b3; }
                    h3 { color: #333; }
                    h4 { color: #007bff; margin-bottom: 5px; }
                    .card { border: 1px solid #ddd; border-radius: 8px; padding: 15px; margin: 10px 0; background-color: #fff; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
                    .infirmier-card { background-color: #e7f3ff; } /* Bleu clair pour infirmiers */
                    .patient-card { background-color: #fff3e6; } /* Orange clair pour patients */
                    img { max-width: 100px; border-radius: 50%; margin: 10px 0; }
                    p { margin: 5px 0; }
                    hr { border: 0; border-top: 1px solid #eee; }
                    .visite { font-style: italic; color: #555; }
                </style>
            </head>
            <body>
                <h1>Cabinet : <xsl:value-of select="/cab:cabinet/cab:nom"/></h1>
                
                <h3>Infirmiers :</h3>
                <xsl:apply-templates select="/cab:cabinet/cab:infirmiers/cab:infirmier"/>
                <h3>Patients :</h3>
                <xsl:apply-templates select="/cab:cabinet/cab:patients/cab:patient"/>
            </body>
        </html>
    </xsl:template>

    <!-- Template pour infirmier -->
    <xsl:template match="cab:infirmier">
        <div class="card infirmier-card">
            <h4>
                <xsl:value-of select="cab:nom"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="cab:prénom"/>
            </h4>
            <p>ID : <xsl:value-of select="cab:id"/> </p>
            <img src="images/{cab:photo}" alt="Photo de {cab:prénom} {cab:nom}" style="width:120px; height:120px; object-fit:cover;"/>
        </div>
        <hr/>
    </xsl:template>

    <!-- Template pour patient -->
    <xsl:template match="cab:patient">
        <div class="card patient-card">
            <h4>
                <xsl:value-of select="cab:nom"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="cab:prenom"/>
            </h4>
            <p>Date de Naissance : <xsl:value-of select="cab:dateNaissance"/> </p>
            <p>Numéro Sécu : <xsl:value-of select="cab:numero"/> </p>
            <p>Sexe : <xsl:value-of select="cab:sexe"/> </p>
            <xsl:apply-templates select="cab:adresse"/>
            <xsl:apply-templates select="cab:visite"/>
        </div>
        <hr/>
    </xsl:template>

    <!-- Template pour adresse -->
    <xsl:template match="cab:adresse">
        <p>Adresse : <xsl:value-of select="cab:numero"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="cab:rue/@typeVoie"/>
            <xsl:value-of select="cab:rue/@nom"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="@codePostal"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="cab:ville"/>
            <xsl:if test="@etage">
                (Étage : <xsl:value-of select="@etage"/>)
            </xsl:if>
        </p>
    </xsl:template>

    <!-- Template pour visite -->
    <xsl:template match="cab:visite">
        <p class="visite">Visite le : <xsl:value-of select="@date"/>
            <xsl:text> </xsl:text>
            <xsl:if test="@intervenant">(Intervenant ID : <xsl:value-of select="@intervenant"/>)</xsl:if>
            <br/>
            Acte : <xsl:value-of select="cab:acte/@intitule"/>
            <xsl:text> (</xsl:text>
            <xsl:if test="cab:acte/@id">ID : <xsl:value-of select="cab:acte/@id"/></xsl:if>
            <xsl:text> )</xsl:text>
            <xsl:text> - Lettre Clé : </xsl:text>
            <xsl:value-of select="cab:acte/@lettreCle"/>
        </p>
    </xsl:template>
</xsl:stylesheet>