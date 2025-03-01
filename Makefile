download:
	curl -OL https://data.humdata.org/dataset/ee4a485c-9180-43db-9672-55e18dac5f96/resource/084a5b03-c52d-48cc-9334-2e4efd1bedea/download/tls_adm_who_ocha_20200911_shp.zip
	unzip -d src tls_adm_who_ocha_20200911_shp.zip

ADM0 = src/tls_admbnda_adm0_who_ocha_20200911.shp
ADM1 = src/tls_admbnda_adm1_who_ocha_20200911.shp
ADM2 = src/tls_admbnda_adm2_who_ocha_20200911.shp
ADM3 = src/tls_admbnda_adm3_who_ocha_20200911.shp
BNDL = src/tls_admbndl_admALL_who_ocha_itos_20200911.shp
BNDP = src/tls_admbndp_admALL_who_ocha_itos_20200911.shp

produce: 
	(ogr2ogr -of GeoJSONSeq /vsistdout/ $(BNDL) -select admLevel | \
	jq -c -f bndl.jq ; \
	ogr2ogr -of GeoJSONSeq /vsistdout/ $(BNDP) -select ADM1_EN,ADM2_EN,ADM3_EN | \
	jq -c -f bndp.jq ; \
	ogr2ogr -of GeoJSONSeq /vsistdout/ $(ADM0) -select ADM0_EN,ADM0_PCODE | \
	jq -c -f adm0.jq ; \
	ogr2ogr -of GeoJSONSeq /vsistdout/ $(ADM1) -select ADM1_EN,ADM1_PCODE | \
	jq -c -f adm1.jq ; \
	ogr2ogr -of GeoJSONSeq /vsistdout/ $(ADM2) -select ADM2_EN,ADM2_PCODE | \
	jq -c -f adm2.jq ; \
	ogr2ogr -of GeoJSONSeq /vsistdout/ $(ADM3) -select ADM3_EN,ADM3_PCODE | \
	jq -c -f adm3.jq ; \
	) | tippecanoe -f -o docs/a.pmtiles --maximum-zoom=14

style:
	pkl eval -f json style.pkl > docs/style.json

host:
	budo -d docs

