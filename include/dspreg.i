.DEFINE MVOLL			$0C
.DEFINE MVOLR			$1C
.DEFINE EVOLL			$2C
.DEFINE EVOLR			$3C
.DEFINE KON				$4C
.DEFINE KOF				$5C
.DEFINE FLG				$6C
.DEFINE ENDX			$7C

.DEFINE EFB				$0D
.DEFINE PMON			$2D
.DEFINE NON				$3D
.DEFINE EON				$4D
.DEFINE DIR				$5D
.DEFINE ESA				$6D
.DEFINE EDL				$7D

.DEFINE FIR0			$0F
.DEFINE FIR1			$1F
.DEFINE FIR2			$2F
.DEFINE FIR3			$3F
.DEFINE FIR4			$4F
.DEFINE FIR5			$5F
.DEFINE FIR6			$6F
.DEFINE FIR7			$7F

.STRUCT VOICE
VOLL					DB
VOLR					DB
PL						DB
PH						DB
SRCN					DB
ADSR1					DB
ADSR2					DB
GAIN					DB
ENVX					DB
OUTX					DB
.ENDST

.ENUM $00
V0						INSTANCEOF VOICE
.ENDE

.ENUM $10
V1						INSTANCEOF VOICE
.ENDE

.ENUM $20
V2						INSTANCEOF VOICE
.ENDE

.ENUM $30
V3						INSTANCEOF VOICE
.ENDE

.ENUM $40
V4						INSTANCEOF VOICE
.ENDE

.ENUM $50
V5						INSTANCEOF VOICE
.ENDE

.ENUM $60
V6						INSTANCEOF VOICE
.ENDE

.ENUM $70
V7						INSTANCEOF VOICE
.ENDE
