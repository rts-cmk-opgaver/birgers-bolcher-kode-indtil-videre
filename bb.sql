
--
-- Struktur-dump for tabellen `bolche`
--

CREATE TABLE `bolche` (
  `id` int(11) NOT NULL,
  `navn` varchar(30) NOT NULL,
  `fk_farve` int(11) NOT NULL,
  `vaegt` int(11) NOT NULL,
  `fk_smag` int(11) NOT NULL,
  `fk_styrke` int(11) NOT NULL,
  `pris` int(11) NOT NULL,
  `fk_surhed` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Data dump for tabellen `bolche`
--

INSERT INTO `bolche` (`id`, `navn`, `fk_farve`, `vaegt`, `fk_smag`, `fk_styrke`, `pris`, `fk_surhed`) VALUES
(2, 'Jordbær', 1, 11, 1, 1, 16, 1),
(3, 'Appelsin', 2, 12, 3, 1, 13, 1),
(5, 'Citron', 3, 10, 2, 1, 14, 2),
(6, 'Salmiaktop', 4, 6, 4, 3, 12, 1),
(7, 'Blå Haj', 5, 22, 5, 2, 19, 3),
(8, 'Rød Perle', 1, 8, 1, 2, 9, 1),
(9, 'Gul perle', 3, 8, 2, 2, 10, 2),
(10, 'Blå Perle', 6, 8, 5, 3, 11, 3);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `farve`
--

CREATE TABLE `farve` (
  `id` int(11) NOT NULL,
  `navn` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Data dump for tabellen `farve`
--

INSERT INTO `farve` (`id`, `navn`) VALUES
(6, 'blaa'),
(8, 'grå'),
(3, 'gul'),
(5, 'lyseblå'),
(2, 'orange'),
(1, 'rød'),
(4, 'sort');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `smag`
--

CREATE TABLE `smag` (
  `id` int(11) NOT NULL,
  `navn` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Data dump for tabellen `smag`
--

INSERT INTO `smag` (`id`, `navn`) VALUES
(1, 'jordbær'),
(2, 'citron'),
(3, 'appelsin'),
(4, 'salmiak'),
(5, 'anis');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `styrke`
--

CREATE TABLE `styrke` (
  `id` int(11) NOT NULL,
  `navn` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Data dump for tabellen `styrke`
--

INSERT INTO `styrke` (`id`, `navn`) VALUES
(1, 'mild'),
(2, 'medium'),
(3, 'stærk');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `surhed`
--

CREATE TABLE `surhed` (
  `id` int(11) NOT NULL,
  `navn` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Data dump for tabellen `surhed`
--

INSERT INTO `surhed` (`id`, `navn`) VALUES
(1, 'sødt'),
(2, 'bittert'),
(3, 'let bittert');

--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `bolche`
--
ALTER TABLE `bolche`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `navn` (`navn`),
  ADD KEY `fk_farve` (`fk_farve`),
  ADD KEY `fk_farve_2` (`fk_farve`),
  ADD KEY `fk_smag` (`fk_smag`),
  ADD KEY `fk_styrke` (`fk_styrke`),
  ADD KEY `fk_surhed` (`fk_surhed`);

--
-- Indeks for tabel `farve`
--
ALTER TABLE `farve`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `farve_navn` (`navn`);

--
-- Indeks for tabel `smag`
--
ALTER TABLE `smag`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `styrke`
--
ALTER TABLE `styrke`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `surhed`
--
ALTER TABLE `surhed`
  ADD PRIMARY KEY (`id`);

--
-- Brug ikke AUTO_INCREMENT for slettede tabeller
--

--
-- Tilføj AUTO_INCREMENT i tabel `bolche`
--
ALTER TABLE `bolche`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- Tilføj AUTO_INCREMENT i tabel `farve`
--
ALTER TABLE `farve`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- Tilføj AUTO_INCREMENT i tabel `smag`
--
ALTER TABLE `smag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Tilføj AUTO_INCREMENT i tabel `styrke`
--
ALTER TABLE `styrke`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Tilføj AUTO_INCREMENT i tabel `surhed`
--
ALTER TABLE `surhed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Begrænsninger for dumpede tabeller
--

--
-- Begrænsninger for tabel `bolche`
--
ALTER TABLE `bolche`
  ADD CONSTRAINT `bolche_ibfk_1` FOREIGN KEY (`fk_styrke`) REFERENCES `styrke` (`id`),
  ADD CONSTRAINT `bolche_ibfk_2` FOREIGN KEY (`fk_surhed`) REFERENCES `surhed` (`id`),
  ADD CONSTRAINT `bolche_ibfk_3` FOREIGN KEY (`fk_smag`) REFERENCES `smag` (`id`),
  ADD CONSTRAINT `bolche_ibfk_4` FOREIGN KEY (`fk_farve`) REFERENCES `farve` (`id`);

