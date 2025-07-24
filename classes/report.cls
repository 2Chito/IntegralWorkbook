\ProvidesClass{classes/report}[2023/02/20 report]

% (u)pLaTeX非互換パッケージに対して互換させるパッチを読み込む命令
\RequirePackage{plautopatch}

\NeedsTeXFormat{LaTeX2e}

% 2カラム,A4,フォントサイズ9pt
\LoadClass[
    paper=a4,
    fontsize=11pt,
    disablejfam,
    head_space=30mm,
    foot_space=30mm,
    gutter=25mm,
    fore-edge=25mm,
    linegap=1zw,
    report]
    {jlreq}


\RequirePackage{ifptex}
\RequirePackage{ifluatex}

\PassOptionsToPackage{hyphens}{url}
\RequirePackage{setspace} % 行間設定用パッケージ
\RequirePackage{here} % 好きな位置にfigなどを置くためのパッケージ
\RequirePackage{bm} % ベクトルを大文字で書くためのパッケージ
\RequirePackage[hyphens]{xurl} % URLを表示するためのパッケージ、ハイフンでの改行を許可
\urlstyle{same} % URLの表示形式を本文と同じにする
\RequirePackage{paralist} % インラインリストのパッケージ
\RequirePackage{amssymb, amsmath} % 高度な数式記述用パッケージ
\RequirePackage{mathtools} % 高度な数式記述用パッケージ
\RequirePackage{amsthm} % 定理環境を使用するためのパッケージ
\RequirePackage{newtxtext,newtxmath} % Times系フォントを使用するためのパッケージ
\RequirePackage{tabularray} % 高度な表組み用パッケージ
% \RequirePackage{minted} % ソースコード表示の用パッケージ
\RequirePackage{siunitx} % SI単位記法に準拠した形式で単位を書くためのパッケージ
\RequirePackage{subfiles} % 大規模な文章を分割して記述して、統合するためのパッケージ
\RequirePackage{indentfirst} % 最初の段落でインデントするためのパッケージ
\RequirePackage{framed} % 囲み付き文章を出すためのパッケージ
\RequirePackage{type1cm} % 文字の大きさを自由に変えるためのパッケージ


\ifluatex
    % LuaTeXを日本語で使うための設定
    \RequirePackage{luatexja}
    % 日本語フォントは原ノ味フォントを使用
    \RequirePackage{luatexja-fontspec}
    \RequirePackage[haranoaji,no-math,deluxe]{luatexja-preset}

    % 図表関連のパッケージを読み込む
    \RequirePackage{graphicx}

    % ハイパーリンクを設定
    \RequirePackage[unicode,hidelinks,pdfusetitle]{hyperref}
\else
    \ifuptex
        % upLaTeXのフォントを設定
        \RequirePackage[deluxe]{otf}
        \RequirePackage[haranoaji,noalphabet]{pxchfon}

        % Font shape JY2/hmc/b/n' undefined (Font) using JY2/hmc/bx/n' instead.
        \DeclareFontShape{JY2}{hmc}{b}{n}{<->ssub*hmc/bx/n}{}

        % LaTeX Font: Font shape `JT2/hmc/b/n' undefine(Font)	using `JT2/hmc/m/n' instead.
        \DeclareFontShape{JT2}{hmc}{b}{n}{<->ssub*hmc/m/n}{}

        \DeclareFontShape{JT2}{hgt}{b}{n}{<->ssub*hgt/eb/n}{}

        \DeclareFontShape{JY2}{hgt}{b}{n}{<->ssub*hgt/bx/n}{}

        % 図表関連のパッケージを読み込む
        \RequirePackage{color}
        \RequirePackage[dvipdfmx]{graphicx}

        % ハイパーリンクを設定
        \RequirePackage[dvipdfmx,unicode,hidelinks,pdfusetitle]{hyperref}

    \else
        % pTeXでコンパイルしようとする場合はエラーを出す
        \ClassError{repost}{This class file is for LuaLaTeX or upLaTeX only.}{Use LuaLaTeX or upLaTeX to compile this document.}
    \fi
\fi

% \RequirePackage{enumitem} % 高機能番号付き箇条書きのパッケージ
\RequirePackage{tabularx} % 表の幅を指定するためのパッケージ
\RequirePackage[bibstyle=bibliography,sorting=none,date=year,isbn=false,doi,giveninits,urldate=iso,seconds]{biblatex} % biblatexを使用するためのパッケージ
\addbibresource{references.bib}

\RequirePackage{tikz} % 図を描画するためのパッケージ
\RequirePackage[most]{tcolorbox}
\RequirePackage[dvipsnames, svgnames]{xcolor}
\RequirePackage{pagecolor}
\RequirePackage{qrcode}

% \DeclareFieldFormat*{journaltitle}{\textit{#1}} % 日本語雑誌名を通常に、英語雑誌名を斜体に
% \DeclareFieldFormat*{title}{\textit{#1}}
% \DeclareFieldFormat[inproceedings]{booktitle}{\textit{#1}}
% \DeclareFieldFormat[book]{title}{\textit{#1}}


% キャプションとサブキャプションの設定
\RequirePackage{silence}
\WarningFilter{caption}{Unknown document class (or package)}
\RequirePackage{caption}
\RequirePackage{subcaption}
\captionsetup[figure]{labelsep=quad, labelformat=simple, name=図}
\captionsetup[subfigure]{labelsep=quad, labelformat=simple, name=図}
\renewcommand*{\thefigure}{\thechapter-\arabic{figure}}
\renewcommand*{\thesubfigure}{(\alph{subfigure})}
\captionsetup[table]{labelsep=quad, labelformat=simple, name=Table}

% 本文中のFigureとTableの表記統一のため，\Fig・\Tableを定義
% 引数としてlabelを受け取り，それを使ってFigureやTableを参照する
% \FigTableEqマクロの定義
\newcommand{\FigTableEq}[3][]{%
    \def\temp{#1}%
    \ifx\temp\empty
        {#2~\ref{#3}}%
    \else
        \textbf{#2~\ref{#3}}%
    \fi
}

% \Figマクロの定義
\newcommand{\Fig}[2][]{%
    \FigTableEq[#1]{Fig.}{#2}%
}

% \Figureマクロの定義
\newcommand{\Figure}[2][]{%
    \FigTableEq[#1]{Figure}{#2}%
}

% \Tableマクロの定義
\newcommand{\Table}[2][]{%
    \FigTableEq[#1]{Table}{#2}%
}

% \Equationマクロの定義
\newcommand{\Eq}[2][]{%
    \FigTableEq[#1]{Eq.}{#2}%
}

% sectionのサイズを合わせる
\RenewBlockHeading{chapter}{0}{lines=6,label_format={＃\thechapter},font={\bfseries\Huge},after_label_space=1\jlreq@zw,second_heading_text_indent={-1\jlreq@zw,1\jlreq@zw},subtitle_font={\Large}}
\RenewBlockHeading{section}{1}{font=\huge,after_label_space=1\jlreq@zw}
\RenewBlockHeading{subsection}{2}{font=\LARGE,after_label_space=1\jlreq@zw}
\RenewBlockHeading{subsubsection}{3}{font=\Large,after_label_space=1\jlreq@zw}

% セクション類の空白の設定
\ModifyHeading{section}{before_space=30pt, after_space=30pt}
\ModifyHeading{subsection}{before_space=20pt, after_space=20pt}
\ModifyHeading{subsubsection}{before_space=15pt, after_space=15pt}
% セクションタイトルが一行以下なら下、２行以上なら上
% \ModifyHeading{section}{lines=1}
% \ModifyHeading{subsection}{lines=1}
% \ModifyHeading{subsubsection}{lines=1}

% セクションが連続する際の行取りを設定
\SetBlockHeadingSpaces{
    {_chapter{*},_section{before_space=0pt, after_space=15pt}},
    {_section{*},_subsection{before_space=5pt, after_space=15pt}}
    {_subsection{*},_subsubsection{before_space=5pt, after_space=15pt}}
}

\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{4}

% ★★★ 目次には表示するが、ページには表示しない章コマンドを新しく定義 ★★★
%------------------------------------------------------------------
\newcommand{\silentchapter}[1]{%
  % \clearpage % 新しい章なので改ページ（必要に応じてコメントを外す）
  \refstepcounter{chapter}% 章番号を1つ進め、ラベルで参照できるようにする
  % 目次に「第X章 #1」の形式で項目を追加する
  % \protect\numberline{\thechapter} が、目次での番号付けを正しく行うためのおまじない
  \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}%
}
%------------------------------------------------------------------
\usetikzlibrary{tikzmark}
\usetikzlibrary{shapes.misc}
\usetikzlibrary{calc}
\usetikzlibrary{shadows}

\newtcolorbox{mondai}[4]{% #1=番号, #2=単元名, #3=難易度, #4=URL
  enhanced,
  breakable,
  colback=white,
  colframe=black,
  boxrule=0.8pt,
  arc=1mm,
  width=\textwidth,
  before skip=10pt,
  after skip=10pt,
  top=3pt,
  bottom=3pt,
  left=5pt,
  right=5pt,
  drop shadow={
    shadow xshift=2mm,
    shadow yshift=-2mm,
    opacity=0.3
  },
  overlay={
    % タイトル表示
    \node[anchor=north west, font=\gtfamily\large] at ([xshift=7mm,yshift=-2mm]frame.north west) {例 題};
    \node[anchor=north west, font=\gtfamily\huge\selectfont, text width=1.3cm, align=center, fill=black!20, inner sep=2.7mm] 
      at ([xshift=23mm,yshift=-0.2mm]frame.north west) {#1};
    \node[anchor=north west, font=\gtfamily\large, text width=10cm] 
      at ([xshift=45mm,yshift=-2mm]frame.north west) {#2};
    \node[anchor=north east, font=\Huge, xshift=-7mm, yshift=-2mm] 
      at (frame.north east) {#3};
    % 点線
    \draw[very thick, dotted] ([xshift=5mm,yshift=-11mm]frame.north west) -- ([xshift=-5mm,yshift=-11mm]frame.north east);
    % QRコード（右下）
    \node[anchor=south east, xshift=-7mm, yshift=0.5mm] at (frame.south east) {\qrcode[height=1.0cm]{#4}};
  },
  valign=top,
  before upper={\par\vspace{1.2em}},
  fontupper=\gtfamily\normalsize,
}

% --- 「考え方」の各項目を表示するための新しいコマンド ---
% 使い方： \approachitem{ここに右側の列の文章を入れる}
\newcommand{\approachitem}[1]{%
    \par\noindent
    \begin{tblr}{
        width = \linewidth,
        colspec = {Q[l,m,font=\bfseries] | p{130mm}},
        vline{2} = {2pt, solid},
    }
        考え方 ▶ & \centering #1 \\
    \end{tblr}
}

% --- 「解」の見出しコマンドを定義 ---
\newcommand{\solutionhead}{%
    \vspace{3mm}
    \noindent
    \hspace{1mm}
    \begin{tikzpicture}[baseline=(char.base)]
    
        % --- 背景の五角形を手作業で描画 ---
        \fill[black!60,rounded corners=2pt]
            (2.5em, 0em)  -- % 1. 右端の頂点（矢印の先端）
            (1.7em, 1.0em)  -- % 2. 右上の頂点
            (-1.0em, 1.0em) -- % 3. 左上の頂点
            (-1.0em, -1.0em)-- % 4. 左下の頂点
            (1.7em, -1.0em) -- % 5. 右下の頂点
            cycle;
            
        % --- 「解」の文字を上から重ねる ---
        % テキストを置くだけの、オプションが非常に少ないシンプルなnode
        \node[text=white, font=\Large\bfseries] (char) at (0.2,0) {解};
        
    \end{tikzpicture}
}

% --- itemboxのスタイルを作成 ---
\newtcolorbox{itembox@style}{
    enhanced,
    width=\linewidth-10em,
    center,                % ボックス自体を中央配置してインデント効果を出す
    colback=white,
    colframe=black,
    boxrule=0.5pt,
    sharp corners,
    boxsep=4pt,
    top=-2.5mm,
    before skip=3mm,       % ボックスの前の垂直な空白
    after skip=0pt,        % ボックスの後の垂直な空白
}

% --- \Itembox を定義 ---
% 使い方： \Itembox{ align* の中身をここに書く }
\newcommand{\Itembox}[1]{%
    \begin{itembox@style}
        \vspace{-5pt} % 上余白の調整（任意で調整）
        \begin{minipage}[c]{\linewidth}
            \begin{align*}
                #1
            \end{align*}
        \end{minipage}
        \vspace{-5pt} % 下余白の調整（任意で調整）
    \end{itembox@style}
}

% --- 新しい「Focus」ポイント用のボックス環境を定義 ---
% 使い方： \begin{focuspoint} (ここに本文) \end{focuspoint}
\newtcolorbox{focusbox}{
  enhanced,
  colback=white,
  colframe=black,
  boxrule=0.8pt,
  left=2mm,
  right=2mm,
  top=2mm,
  bottom=2mm,
  before skip=10pt,
  after skip=10pt,
  sharp corners,
  width=\dimexpr\linewidth-4mm\relax,
  enlarge left by=4mm, % 左に4mm余白
  fontupper=\sffamily,
  overlay={
    % F：赤背景 + 下右の黒線
    \node[anchor=south west, fill=red!70, text=white, font=\rmfamily,
          minimum width=4mm, minimum height=4mm, inner sep=1pt,
          path picture={
            \draw[line width=1.5pt, black]
              (path picture bounding box.south west) -- (path picture bounding box.south east);
            \draw[line width=1.5pt, black]
              (path picture bounding box.south east) -- (path picture bounding box.north east);
          }]
          at ([xshift=-3.8mm, yshift=-0.35mm]frame.north west) {F};

    % ocus文字
    \node[anchor=base west, font=\rmfamily, text=black]
          at ([xshift=-1mm, yshift=0.5mm]frame.north west) {ocus};
  },
}
