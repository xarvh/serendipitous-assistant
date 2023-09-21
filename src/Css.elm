module Css exposing (..)

import Saleha


css =
    """
@font-face {
    font-family: 'Saleha';
    src: url(data:font/ttf;base64,""" ++ Saleha.salehaRegular ++ """) format('truetype');
}


body {
  background-color: #201f36;
  color: rgb(223, 224, 201);
  font-family: 'Electrolize', sans-serif;
}

button {
  min-width: 2em;
}


.card {
   background-color: #101026;
   border: 1px solid #000;
   border-radius: 16px;
   padding: 1em;
   margin: 1em;
 }



/* Tooltip */


.tooltip {
  display: none;
  position: fixed;
  right: 1rem;
  top: 1rem;
  background-color: #101026;
  border: 2px rgb(223, 224, 201) solid;
  border-radius: 16px;
  z-index: 1;
  padding: 1rem;
}

*:has(> .tooltip) {
  position: relative;
}

*:hover > .tooltip {
  display: block;
}




/* Media */

.portrait {
  width: 8em;
  min-height: 8em;
  height: fit-content;
  background-color: rgb(223, 224, 201);
}

.media-layout {
  display: flex;
}

/* TODO: use width instead */
@media (orientation: portrait) {
  .media-layout {
      flex-direction: column;
  }
  .portrait {
      display: none;
  }
}


/* atomic */

.justifyCenter { display: flex; justify-content: center; }
.alignCenter { display: flex; align-items: center; }
.row { display: flex; }
.w100 { width: 100%; }

.mt1 { margin-top: 0.5em; }
.mr1 { margin-right: 0.5em; }
.mb1 { margin-bottom: 0.5em; }
.ml1 { margin-left: 0.5em; }

.mt2 { margin-top: 1em; }
.mr2 { margin-right: 1em; }
.mb2 { margin-bottom: 1em; }
.ml2 { margin-left: 1em; }

.textRight { text-align: right; }
.bold { font-weight: bold; }
.excess { color: red; }
.lowlight { color: rgb(150, 150, 150); }
.styled { font-family: 'Saleha'; font-size: 150%; }
.strikeout { text-decoration: line-through; }


.hidden { visibility: hidden; }


/* specific */

.pool-label { width: 6em; }
.pool-value { width: 2em; text-align: right; padding-right: 0.5em; }
.bar { height: 1.2em; width: fit-content; }

"""
