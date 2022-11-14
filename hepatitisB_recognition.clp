; >>> templates <<<

(deftemplate HBsAg "HbsAg is either its value is positive or negative"
    (slot value)
)

(deftemplate anti-HDV "Anti-HDV is either positive or negative"
    (slot value)
)

(deftemplate anti-HBc "Anti-HBc is either positive or negative"
    (slot value)
)

(deftemplate anti-HBs "Anti-HBs is either positive or negative"
    (slot value)
)

(deftemplate IgM-anti-HBc "igM-anti-HBC is either positive or negative"
    (slot value)
)

; >>> Facts Setter <<<

(defrule init-input "Get HBsAg"
    =>
    (printout t "HBsAg? ")
    (bind ?value (read))
    (assert (HBsAg (value ?value)))
)

(defrule get-anti-HDV "Get anti-HDV"
    (HBsAg (value positive))
    =>
    (printout t "anti-HDV? ")
    (bind ?value (read))
    (assert (anti-HDV (value ?value)))
)

(defrule get-anti-HBc "Get anti-HBc"
    (HBsAg (value positive))
    (anti-HDV (value negative))
    =>
    (printout t "anti-HBc? ")
    (bind ?value (read))
    (assert (anti-HBc (value ?value)))
)

(defrule get-anti-HBs "Get anti-HBs"
    (HBsAg (value positive))
    (anti-HDV (value negative))
    (anti-HBc (value positive))
    =>
    (printout t "anti-HBs? ")
    (bind ?value (read))
    (assert (anti-HBs (value ?value)))
)

(defrule get-IgM-anti-HBc "Get IgM anti-HBc"
    (HBsAg (value positive))
    (anti-HDV (value negative))
    (anti-HBc (value positive))
    (anti-HBs (value negative))
    =>
    (printout t "IgM anti-HBc? ")
    (bind ?value (read))
    (assert (IgM-anti-HBc (value ?value)))
)


; >>> Prediction Getter <<<

(defrule print-Hepatitis-B+D "Prediction is Hepatitis B+D"
    (HBsAg (value positive))
    (anti-HDV (value positive))
    =>
    (printout t crlf "Hasil Prediksi = Hepatitis B+D" crlf)
)

(defrule print-uncertain-configuration "Prediction is Uncertain configuration"
    (or (and    (HBsAg (value positive))
                (anti-HDV (value negative))
                (anti-HBc (value negative)))
        (and    (HBsAg (value positive))
                (anti-HDV (value negative))
                (anti-HBc (value positive))
                (anti-HBs (value positive)))
    )
    =>
    (printout t crlf "Hasil Prediksi = Uncertain configuration" crlf)
)

(defrule print-acute-infection "Prediction is Acute infection"
    (HBsAg (value positive))
    (anti-HDV (value negative))
    (anti-HBc (value positive))
    (anti-HBs (value negative))
    (anti-HBs (value negative))
    =>
    (printout t crlf "Hasil Prediksi = Acute infection" crlf)
)

(defrule print-chronic-infection "Prediction is Chronic infection"
    (HBsAg (value positive))
    (anti-HDV (value negative))
    (anti-HBc (value positive))
    (anti-HBs (value negative))
    (anti-HBs (value positive))
    =>
    (printout t crlf "Hasil Prediksi = Chronic infection" crlf)
)