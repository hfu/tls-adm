. + {
  tippecanoe: {
    minzoom: (
      if .properties.admLevel == 99 then 5
      elif .properties.admLevel == 0 then 5
      elif .properties.admLevel == 1 then 7
      elif .properties.admLevel == 2 then 9
      elif .properties.admLevel == 3 then 11
      end
    ),
    maxzoom: 14,
    layer: "bndl"
  }
}

