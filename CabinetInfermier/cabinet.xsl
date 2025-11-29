<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cab = "http://www.univ-grenoble-alpes.fr/l3miage/medical">
    
                <xsl:output method="html"/>
                
                <!-- point d'entée de la transformation -->
                <xsl:template match="/">
                    <html>
                        <body>
                            <h1>Cabinet : <xsl:value-of select="/cab:cabinet/cab:nom"/></h1>
                            <h2>Gérer par : <xsl:value-of select="/cab:cabinet/cab:prénom"/></h2>
                            
                            <h3>Infirmiers: </h3>
                            <xsl:apply-templates select="/cab:cabinet/cab:infirmiers/cab:infirmier"/>

                            <h3>Patients: </h3>
                            <xsl:apply-templates select="/cab:cabinet/cab:patients/cab:patient"/>
                        </body>
                    </html>
                </xsl:template>
    
    
    <!-- Template pour infirmier -->
    <xsl:template match="cab:infirmier">
            <h4>
                <xsl:value-of select="cab:nom"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="cab:prenom"/>
            </h4>
        <p>ID: <xsl:value-of select="cab:id"/> </p>
        <img src="{cab:photo}" />
        <hr/>   <!-- ligne horizontale pour séparer les infirmiers -->
    </xsl:template>
    
    
    
    
    <!-- Template pour patient -->
    <xsl:template match="cab:patient">
        <h4>
        <xsl:value-of select="cab:nom"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="cab:prenom"/>
        </h4>
        <p>Date de Naissance: <xsl:value-of select="cab:dateNaissance"/> </p>
        <p>Numero Secu: <xsl:value-of select="cab:numero"/> </p>
        <p>Sexe: <xsl:value-of select="cab:sexe"/> </p>
        
        <xsl:apply-templates select="/cab:cabinet/cab:patients/cab:adresse"/>
        <xsl:apply-templates select="/cab:cabinet/cab:patients/cab:visite"/>
        <hr/>
    </xsl:template>

    <!-- Template pour adresse -->
    <xsl:template match="cab:adresse">
        <p> Adresse:
            <xsl:value-of select="cab:numero"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="cab:rue/@typeVoie"/> <xsl:value-of select="cab:rue/@nom"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="@codePostal"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="cab:ville"/>
            <xsl:if test="@etage"> Etage: <xsl:value-of select="@etage"/> </xsl:if>
        </p>
    </xsl:template>        
    
    
    <!-- Template pour visite -->
    <xsl:template match="cab:visite">
        <p> 
            Visite le: <xsl:value-of select="@date"/>
            <xsl:text> </xsl:text>
            <xsl:if test="@intervenant">Intervenant ID: <xsl:value-of select="@intervenant"/></xsl:if>
            <br/>  <!-- aller à la ligne suivante -->
            Acte:
            <xsl:value-of select="cab:acte/@intitule"/>
            <xsl:text> (ID: </xsl:text><xsl:value-of select="cab:acte/@id"/> <xsl:text> )</xsl:text>
            <xsl:text> LettreCle: </xsl:text>
            <xsl:value-of select="cab:acte/@lettreCle"/>
            
            
        </p>
    </xsl:template>

</xsl:stylesheet>    
    