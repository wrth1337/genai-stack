CALL apoc.periodic.iterate(
    "
    MATCH (n:Regesta)
    RETURN n
    ",
    "
    WITH n, [
        {reg: '<[^>]*>', rep: ''},
        {reg: 'abt\.', rep: 'abteilung'},
        {reg: 'ADB\\b', rep: 'Allgemeine Deutsche Biographie'},
        {reg: 'ADK\\b', rep: 'Altes Domkapitel’sches Archiv'},
        {reg: 'A\.m\.d\.i\.', rep: 'Ad mandatum domini imperatoris'},
        {reg: 'A\.m\.d\.i\.c\.', rep: 'Ad mandatum domini imperatoris in consilio'},
        {reg: 'A\.m\.d\.i\.p\.', rep: 'Ad mandatum domini imperatoris proprium'},
        {reg: 'A\.m\.d\.r\.', rep: 'Ad mandatum domini regis'},
        {reg: 'A\.m\.d\.r\.i\.c\.', rep: 'Ad mandatum domini regis in consilio'},
        {reg: 'A\.m\.p\.d\.i\.', rep: 'Ad mandatum proprium domini imperatoris'},
        {reg: 'A\.m\.p\.d\.i\.i\.c\.', rep: 'Ad mandatum proprium domini imperatoris in consilio'},
        {reg: 'Anm\.', rep: 'Anmerkung'},
        {reg: 'AO\\b', rep: 'Ausstellungsort'},
        {reg: 'AÖG\\b', rep: 'Archiv für österreichische Geschichte'},
        {reg: 'Art\.', rep: 'Artikel'},
        {reg: 'aufgedr\.', rep: 'aufgedrückt'},
        {reg: 'BayHStA\\b', rep: 'Bayerisches Hauptstaatsarchiv'},
        {reg: 'Bd\.', rep: 'Band'},
        {reg: 'Bde\.', rep: 'Bände'},
        {reg: 'BDK\\b', rep: 'Bischöflich Domkapitel’sches Archiv'},
        {reg: 'Bearb\.', rep: 'Bearbeiter'},
        {reg: 'begr\.', rep: 'begründet'},
        {reg: 'bes\.', rep: 'besonders'},
        {reg: 'Bf\.', rep: 'Bischof'},
        {reg: 'bfl\.', rep: 'bischöflich'},
        {reg: 'Bg\.', rep: 'Bürger'},
        {reg: 'Bggf\.', rep: 'Burggraf'},
        {reg: 'BGRR\\b', rep: 'Beiträge zur Geschichte des Bistums Regensburg'},
        {reg: 'BZAR\\b', rep: 'Bischöfliches Zentralarchiv Regensburg'},
        {reg: 'bzw\.', rep: 'beziehungsweise'},
        {reg: '\\sca\.', rep: ' circa'},
        {reg: 'Cart\.', rep: 'Carton'},
        {reg: 'C\.d\.i\.i\.c\.', rep: 'Commissio domini imperatoris in consilio'},
        {reg: 'C\.d\.i\.p\.', rep: 'Commissio domini imperatoris propria'},
        {reg: 'C\.d\.r\.', rep: 'Commissio domini regis'},
        {reg: 'C\.d\.r\.i\.c\.', rep: 'Commissio domini regis in consilio'},
        {reg: 'C\.d\.r\.p\.', rep: 'Commissio domini regis propria'},
        {reg: 'C\.p\.d\.r\.', rep: 'Commissio propria domini regis'},
        {reg: '\\sd\.', rep: ' Denar/Pfennig'},
        {reg: '\\sden\.', rep: ' Denar/Pfennig'},
        {reg: 'Dép\.', rep: 'Département'},
        {reg: 'dies\.', rep: 'dieselben'},
        {reg: 'Diöz\.', rep: 'Diözese'},
        {reg: 'DRW\\b', rep: 'Deutsches Rechtswörterbuch'},
        {reg: 'dgl\.', rep: 'desgleichen'},
        {reg: 'Eb\.', rep: 'Erzbischof'},
        {reg: 'ebd\.', rep: 'ebenda'},
        {reg: '\\sed\.', rep: 'ediert'},
        {reg: 'eingedr\.', rep: 'eingedrückt'},
        {reg: 'F\.', rep: 'Friedrich'},
        {reg: 'ff\.', rep: 'folgende'},
        {reg: '\\sf\.', rep: 'folgende'},
        {reg: 'Fasz\.', rep: 'Faszikel'},
        {reg: 'fl\.', rep: '(Florentiner) Gulden'},
        {reg: 'flor\.', rep: '(Florentiner) Gulden'},
        {reg: 'fol\.', rep: 'Folio'},
        {reg: 'FRA\\b', rep: 'Fontes Rerum Austriacarum'},
        {reg: 'FS\\b', rep: 'Festschrift'},
        {reg: 'Gde\.', rep: 'Gemeinde'},
        {reg: 'gen\.', rep: 'genannt'},
        {reg: 'Gf\.', rep: 'Graf'},
        {reg: 'Gff\.', rep: 'Grafen'},
        {reg: 'Gft\.', rep: 'Grafschaft'},
        {reg: 'H\.', rep: 'Heft'},
        {reg: 'HAB\\b', rep: 'Historischer Atlas von Bayern'},
        {reg: 'Hg\.', rep: 'Herausgeber'},
        {reg: 'hg\.', rep: 'herausgegeben'},
        {reg: 'HJB\\b', rep: 'Historisches Jahrbuch'},
        {reg: 'HL\\b', rep: 'Hochstift Literalien'},
        {reg: 'Hl\.,\\b', rep: 'heilig'},
        {reg: 'HHStA\\b', rep: 'Haus-, Hof- und Staatsarchiv'},
        {reg: 'HRG\\b', rep: 'Handwörterbuch zur deutschen Rechtsgeschichte'},
        {reg: 'HU\\b', rep: 'Hochstift Urkunden'},
        {reg: 'HZ\\b', rep: 'Historische Zeitschrift'},
        {reg: 'Hz\.', rep: 'Herzog'},
        {reg: 'Hzn\.', rep: 'Herzogin'},
        {reg: 'Hztm\.', rep: 'Herzogtum'},
        {reg: 'Hzz\.', rep: 'Herzöge'},
        {reg: '\\sid\.', rep: ' Iden'},
        {reg: 'Jh\.', rep: 'Jahrhundert'},
        {reg: 'K\.', rep: 'Kaiser'},
        {reg: 'Kart\.', rep: 'Karton'},
        {reg: 'Kast\.', rep: 'Kasten'},
        {reg: 'Kf\.', rep: 'Kurfürst'},
        {reg: 'Kff\.', rep: 'Kurfürsten'},
        {reg: 'Kg\.', rep: 'König'},
        {reg: 'Kgg\.', rep: 'Könige'},
        {reg: 'kgl\.', rep: 'königlich'},
        {reg: 'KL\\b', rep: 'Klosterliteralien'},
        {reg: 'Konv\.', rep: 'Konvolut'},
        {reg: 'Konz\.', rep: 'Konzept'},
        {reg: 'Kop\.', rep: 'Kopie'},
        {reg: 'ksl\.', rep: 'kaiserlich'},
        {reg: 'KVr\\b', rep: 'Kanzleivermerk recto'},
        {reg: 'KVv\\b', rep: 'Kanzleivermerk verso'},
        {reg: '\\slb\.', rep: ' Libra/Pfund'},
        {reg: 'LexMA\\b', rep: 'Lexikon des Mittelalters'},
        {reg: 'Lit\.', rep: 'Literatur'},
        {reg: 'Lkr\.', rep: 'Landkreis'},
        {reg: 'Masch\.', rep: 'Maschinenschrift'},
        {reg: 'MB\\b', rep: 'Monumenta Boica'},
        {reg: 'Mgf\.', rep: 'Markgraf'},
        {reg: 'MIÖG\\b', rep: 'Mitteilungen des Instituts für österreichische Geschichtsforschung'},
        {reg: 'MKL\\b', rep: 'Mátyás király levelei'},
        {reg: 'M\.', rep: 'Maximilian'},
        {reg: 'ms\.', rep: 'maschinenschriftlich'},
        {reg: 'N\.', rep: 'Nomen'},
        {reg: '\\sn\.', rep: ' Nummer'},
        {reg: 'ND\\b', rep: 'Neudruck'},
        {reg: 'NF\\b', rep: 'Neue Folge'},
        {reg: ' not\.', rep: 'notariell'},
        {reg: 'OA\\b', rep: 'Ordinariatsarchiv'},
        {reg: 'öff\.', rep: 'öffentlich'},
        {reg: 'Orgg\.', rep: 'Originale'},
        {reg: 'Org\.', rep: 'Original'},
        {reg: 'Pap\.', rep: 'Papier'},
        {reg: 'Perg\.', rep: 'Pergament'},
        {reg: 'Pf\.', rep: 'Pfund'},
        {reg: 'Pfgft\.', rep: 'Pfalzgraf, Pfalzgrafschaft'},
        {reg: 'Pfgf\.', rep: 'Pfalzgraf, Pfalzgrafschaft'},
        {reg: 'Ps\.', rep: 'Pergamentstreifen'},
        {reg: 'publ\.', rep: 'publicus'},
        {reg: 'QE\\b', rep: 'Quellen und Erörterungen'},
        {reg: '\\sr\\b', rep: ' recto'},
        {reg: 'RB\\b', rep: 'Regesta Boica'},
        {reg: 'Reg\.', rep: 'Regest'},
        {reg: 'Rgb\.', rep: 'Regensburg'},
        {reg: 'Rgber\.', rep: 'Regensburger'},
        {reg: 'rhein\.', rep: 'rheinisch'},
        {reg: 'RI\\b', rep: 'Regesta Imperii'},
        {reg: 'RL\\b', rep: 'Reichsstadt Literalien'},
        {reg: 'röm\.', rep: 'römisch'},
        {reg: 'Rta\\b', rep: 'registrata'},
        {reg: 'RTA\\b', rep: 'Reichstagsakten'},
        {reg: 'RU\\b', rep: 'Reichsstadt Urkunden'},
        {reg: 'S\\b', rep: 'Siegel'},
        {reg: 'S\.', rep: 'Seite'},
        {reg: 'Sign\.', rep: 'Signatur'},
        {reg: 'Sp\.', rep: 'Spalte'},
        {reg: 'Ss\.', rep: 'Seidenschnur'},
        {reg: 'St\.', rep: 'Sankt'},
        {reg: 'StadtA\\b', rep: 'Stadtarchiv'},
        {reg: 'Tl\.', rep: 'Teil'},
        {reg: 'Tle\.', rep: 'Teile'},
        {reg: 'u\.a\.', rep: 'und andere'},
        {reg: 'UB\\b', rep: 'Urkundenbuch'},
        {reg: 'undat\.', rep: 'undatiert'},
        {reg: 'ung\.', rep: 'ungarisch'},
        {reg: 'Urk\.', rep: 'Urkunde'},
        {reg: '\\sv\\b', rep: ' verso'},
        {reg: '\\sv\.', rep: ' von'},
        {reg: 'vgl\.', rep: 'vergleiche'},
        {reg: 'VHVO\\b', rep: 'Verhandlungen des Historischen Vereins von Oberpfalz und Regensburg'},
        {reg: 'Vorurk\.', rep: 'Vorurkunde'},
        {reg: 'VSWG\\b', rep: 'Vierteljahresschrift für Sozial- und Wirtschaftsgeschichte'},
        {reg: 'z\.B\.', rep: 'zum Beispiel'},
        {reg: 'ZBLG\\b', rep: 'Zeitschrift für bayerische Landesgeschichte'},
        {reg: 'zeitgen\.', rep: 'zeitgenössisch'}
    ] AS replacements
    UNWIND replacements AS r
    SET n.summary = apoc.text.replace(n.summary, r.reg, r.rep)
    ",
    {batchSize: 1000, parallel: true}
)