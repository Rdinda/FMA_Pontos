<script setup lang="ts">
import { ref, onMounted } from 'vue';
import {
  BookOpen,
  Download,
  Github,
  Loader2,
  Smartphone,
  Zap,
  Music,
  Heart,
  Play,
  Pause,
  ChevronLeft,
  ChevronRight,
  Layers,
  Sparkles,
  Volume2,
} from 'lucide-vue-next';

import ReleaseNotes from './ReleaseNotes.vue';

interface GithubRelease {
  id: number;
  tag_name: string;
  name: string;
  published_at: string;
  body: string;
  assets: {
    name: string;
    browser_download_url: string;
  }[];
  html_url: string;
}

const latestRelease = ref<GithubRelease | null>(null);
const pastReleases = ref<GithubRelease[]>([]);
const loading = ref(true);
const error = ref(false);

const repoOwner = 'Rdinda';
const repoName = 'FMA_Pontos';

// Interactive Entity / Orixá list
const entities = ref([
  {
    name: 'Ogum',
    type: 'Orixá da Lei e Caminhos',
    song: 'Pisada de Ogum',
    subtitle: 'Caminhos e Lei',
    image: '/imagens/orixa/ogum.png',
    themeColor: 'from-blue-900/35 to-stone-950',
  },
  {
    name: 'Oxalá',
    type: 'Orixá da Paz e Fé',
    song: 'Hino ao Senhor do Bonfim',
    subtitle: 'Paz e Fé',
    image: '/imagens/orixa/oxala.png',
    themeColor: 'from-amber-100/10 to-stone-950',
  },
  {
    name: 'Iemanjá',
    type: 'Orixá da Geração e Vida',
    song: 'Beira Mar',
    subtitle: 'Rainha das Ondas',
    image: '/imagens/orixa/iemanja.png',
    themeColor: 'from-sky-900/30 to-stone-950',
  },
  {
    name: 'Oxum',
    type: 'Orixá do Amor e Prosperidade',
    song: 'Canto de Oxum',
    subtitle: 'Amor e Ouro',
    image: '/imagens/orixa/oxum.png',
    themeColor: 'from-yellow-900/30 to-stone-950',
  },
  {
    name: 'Xangô',
    type: 'Orixá da Justiça',
    song: 'Kaô Kabecile Xangô',
    subtitle: 'Justiça e Fogo',
    image: '/imagens/orixa/xango.png',
    themeColor: 'from-red-950/40 to-stone-950',
  },
  {
    name: 'Oxóssi',
    type: 'Orixá do Conhecimento e Fartura',
    song: 'Oke Arô Oxóssi',
    subtitle: 'Cura e Fartura',
    image: '/imagens/orixa/oxossi.png',
    themeColor: 'from-emerald-950/40 to-stone-950',
  },
  {
    name: 'Pretos Velhos',
    type: 'Linha de Sabedoria',
    song: 'Adorei as Almas',
    subtitle: 'Sabedoria e Acalanto',
    image: '/imagens/pretovelho.png',
    themeColor: 'from-stone-800/40 to-stone-950',
  },
  {
    name: 'Exu',
    type: 'Linha de Esquerda / Vitalidade',
    song: 'Portão de Ferro',
    subtitle: 'Vitalidade e Caminhos',
    image: '/imagens/exu.png',
    themeColor: 'from-red-950/50 to-stone-950',
  },
  {
    name: 'Caboclos',
    type: 'Linha de Força e Cura',
    song: 'Caboclo Pena Branca',
    subtitle: 'Força e Foco',
    image: '/imagens/caboclo.png',
    themeColor: 'from-green-900/30 to-stone-950',
  },
  {
    name: 'Pombagira',
    type: 'Linha de Esquerda / Equilíbrio',
    song: 'Rosa Vermelha',
    subtitle: 'Estímulo e Desejo',
    image: '/imagens/pombogira.png',
    themeColor: 'from-rose-950/50 to-stone-950',
  },
]);

const activeEntityIndex = ref(0);
const isPlaying = ref(true);

const togglePlay = () => {
  isPlaying.value = !isPlaying.value;
};

const selectEntity = (index: number) => {
  activeEntityIndex.value = index;
  isPlaying.value = true;
};

// Gallery Scrolling Logic
const galleryScrollContainer = ref<HTMLElement | null>(null);

const scrollGallery = (direction: 'left' | 'right') => {
  if (galleryScrollContainer.value) {
    const scrollAmount = 340;
    galleryScrollContainer.value.scrollBy({
      left: direction === 'left' ? -scrollAmount : scrollAmount,
      behavior: 'smooth',
    });
  }
};

onMounted(() => {
  // Fetch releases from GitHub
  fetch(`https://api.github.com/repos/${repoOwner}/${repoName}/releases`)
    .then((res) => {
      if (!res.ok) throw new Error('Failed to fetch releases');
      return res.json();
    })
    .then((data) => {
      if (Array.isArray(data) && data.length > 0) {
        latestRelease.value = data[0];
        pastReleases.value = data.slice(1, 4);
      }
      loading.value = false;
    })
    .catch((err) => {
      console.error(err);
      error.value = true;
      loading.value = false;
    });
});

const scrollToSection = (id: string) => {
  document.getElementById(id)?.scrollIntoView({ behavior: 'smooth' });
};
</script>

<template>
  <div class="min-h-screen overflow-x-hidden bg-black text-stone-200 font-sans selection:bg-[#1DB954] selection:text-black">
    <!-- Header -->
    <header class="fixed top-0 right-0 left-0 z-50 border-b border-white/5 bg-black/80 px-6 py-4 backdrop-blur-md">
      <div class="container mx-auto flex items-center justify-between">
        <div class="flex items-center gap-3 cursor-pointer" @click="scrollToSection('hero')">
          <img
            src="/imagens/emblema_semfundo.png"
            alt="Emblema FMA Pontos"
            class="h-9 w-9 object-contain filter drop-shadow-[0_0_8px_rgba(29,185,84,0.3)]"
            width="36"
            height="36"
          />
          <span class="font-sans text-xl font-black tracking-tight text-white">
            FMA Pontos
          </span>
        </div>
        
        <!-- Navigation Links -->
        <nav class="hidden md:flex items-center gap-8">
          <button @click="scrollToSection('recursos')" class="text-sm font-semibold text-stone-400 hover:text-white transition-colors cursor-pointer">
            Recursos
          </button>
          <button @click="scrollToSection('sobre')" class="text-sm font-semibold text-stone-400 hover:text-white transition-colors cursor-pointer">
            Sobre
          </button>
          <button @click="scrollToSection('galeria')" class="text-sm font-semibold text-stone-400 hover:text-white transition-colors cursor-pointer">
            Galeria de Orixás
          </button>
        </nav>

        <!-- CTA Header -->
        <div class="flex items-center gap-4">
          <button
            @click="scrollToSection('download')"
            class="hidden sm:inline-flex items-center justify-center rounded-full bg-[#1DB954] hover:bg-[#1ed760] px-6 py-2.5 text-sm font-bold text-black transition-all hover:scale-105 hover:shadow-[0_0_20px_rgba(29,185,84,0.4)] cursor-pointer"
          >
            Baixar App
          </button>
        </div>
      </div>
    </header>

    <!-- Hero Section -->
    <section id="hero" class="relative flex min-h-screen items-center justify-center pt-24 pb-12 overflow-hidden bg-gradient-to-b from-black via-[#121212] to-black">
      <!-- Ambient Glows -->
      <div class="pointer-events-none absolute inset-0 overflow-hidden">
        <div class="absolute top-[20%] left-[-10%] h-[60vw] w-[60vw] rounded-full bg-[#1DB954]/10 blur-[120px] pointer-events-none"></div>
        <div class="absolute right-[-10%] bottom-[10%] h-[50vw] w-[50vw] rounded-full bg-emerald-950/20 blur-[100px] pointer-events-none"></div>
      </div>

      <div class="relative z-10 container mx-auto px-6 max-w-7xl">
        <div class="grid grid-cols-1 items-center gap-12 lg:grid-cols-2 lg:gap-16">
          <div class="flex flex-col items-center text-center lg:items-start lg:text-left space-y-8">
            <h1 class="text-5xl md:text-6xl lg:text-7xl font-black font-sans tracking-tight text-white leading-tight">
              Preserve a <br/>
              <span class="text-transparent bg-clip-text bg-gradient-to-r from-[#1DB954] to-emerald-400">
                Tradição e Fé
              </span>
            </h1>

            <p class="text-lg md:text-xl text-stone-400 font-medium max-w-xl leading-relaxed">
              O <strong class="text-white font-bold">FMA Pontos</strong> conecta você às raízes da Umbanda. Acesse letras, organize seus estudos e ouça pontos de Umbanda em uma plataforma moderna e imersiva.
            </p>

            <div class="flex flex-wrap items-center justify-center lg:justify-start gap-4 w-full">
              <button
                @click="scrollToSection('download')"
                class="group flex items-center justify-center gap-3 rounded-full bg-[#1DB954] hover:bg-[#1ed760] px-8 py-4 text-lg font-bold text-black transition-all hover:scale-105 hover:shadow-[0_0_30px_rgba(29,185,84,0.3)] cursor-pointer w-full sm:w-auto"
              >
                <Download class="h-5 w-5" />
                Baixar Agora
              </button>
              
              <a
                href="https://github.com/Rdinda/FMA_Pontos"
                target="_blank"
                rel="noopener noreferrer"
                class="flex items-center justify-center gap-3 rounded-full bg-white/5 hover:bg-white/10 px-8 py-4 text-lg font-semibold text-white border border-white/10 transition-all duration-300 w-full sm:w-auto"
              >
                <Github class="h-5 w-5" />
                Código no GitHub
              </a>
            </div>

            <!-- Version alert badge -->
            <div
              v-if="latestRelease"
              class="inline-flex items-center gap-2 rounded-full border border-[#1DB954]/20 bg-[#1DB954]/10 px-4 py-2 text-sm font-semibold text-[#1DB954]"
            >
              <span class="relative flex h-2 w-2">
                <span class="absolute inline-flex h-full w-full animate-ping rounded-full bg-[#1DB954] opacity-75"></span>
                <span class="relative inline-flex h-2 w-2 rounded-full bg-[#1DB954]"></span>
              </span>
              Novo: Versão {{ latestRelease.tag_name }} Disponível
            </div>
          </div>

          <!-- Interactive Mobile Phone Mockup -->
          <div class="relative flex justify-center items-center py-6">
            <!-- Ambient Glow behind phone -->
            <div class="absolute w-[350px] h-[350px] bg-[#1DB954]/15 rounded-full blur-[100px] pointer-events-none"></div>

            <div class="relative w-[300px] md:w-[330px] h-[610px] md:h-[680px] bg-[#1a1a1a] rounded-[45px] p-2 shadow-[0_25px_60px_-15px_rgba(0,0,0,0.9)] border border-white/10 overflow-hidden transform rotate-[-3deg] hover:rotate-0 transition-transform duration-700 ease-out z-10">
              <div class="absolute inset-0 bg-gradient-to-tr from-white/5 to-transparent rounded-[43px] pointer-events-none"></div>
              
              <!-- Screen area -->
              <div class="w-full h-full bg-black rounded-[38px] overflow-hidden relative flex flex-col">
                <!-- Phone status bar mock -->
                <div class="h-8 w-full flex justify-between items-center px-6 absolute top-0 left-0 z-20">
                  <span class="text-[10px] text-white/70 font-semibold select-none">20:46</span>
                  <div class="flex gap-1.5 items-center opacity-70">
                    <span class="material-symbols-outlined text-[12px] text-white select-none">signal_cellular_4_bar</span>
                    <span class="material-symbols-outlined text-[12px] text-white select-none">wifi</span>
                    <span class="material-symbols-outlined text-[12px] text-white select-none">battery_full</span>
                  </div>
                </div>

                <!-- App Mockup Content -->
                <div class="flex-1 overflow-y-auto pb-24 pt-10 px-4 transition-all duration-500 bg-gradient-to-b" :class="entities[activeEntityIndex].themeColor">
                  <!-- App Header -->
                  <div class="flex items-center gap-2 mb-6 mt-2">
                    <img src="/imagens/emblema_semfundo.png" class="h-6 w-6 object-contain" alt="" />
                    <span class="text-xs font-black text-white tracking-wide uppercase">FMA Pontos</span>
                  </div>

                  <!-- Album / Artwork Card -->
                  <div class="w-full aspect-square rounded-2xl overflow-hidden relative mb-5 shadow-[0_15px_30px_rgba(0,0,0,0.5)] border border-white/5 group">
                    <img
                      :src="entities[activeEntityIndex].image"
                      :alt="entities[activeEntityIndex].name"
                      class="w-full h-full object-cover transition-transform duration-700"
                    />
                    <div class="absolute inset-0 bg-gradient-to-t from-black via-transparent to-transparent opacity-80"></div>
                    <div class="absolute bottom-4 left-4">
                      <span class="bg-[#1DB954] text-black text-[9px] font-black uppercase px-2 py-0.5 rounded-full">Orixá ativo</span>
                      <h2 class="text-2xl font-black text-white mt-1 drop-shadow-md">{{ entities[activeEntityIndex].name }}</h2>
                    </div>
                  </div>

                  <!-- Track Info / Control simulation -->
                  <div class="space-y-4">
                    <div class="flex items-center justify-between p-3 rounded-xl bg-white/5 border border-white/5">
                      <div class="flex flex-col min-w-0">
                        <span class="text-white font-bold text-sm truncate">{{ entities[activeEntityIndex].song }}</span>
                        <span class="text-stone-400 text-xs truncate">{{ entities[activeEntityIndex].type }}</span>
                      </div>
                      <button @click="togglePlay" class="w-8 h-8 rounded-full bg-[#1DB954] text-black flex items-center justify-center hover:scale-105 transition-all">
                        <Pause v-if="isPlaying" class="h-3.5 w-3.5 fill-black" />
                        <Play v-else class="h-3.5 w-3.5 fill-black ml-0.5" />
                      </button>
                    </div>

                    <!-- Other Points simulated -->
                    <div class="text-[10px] font-black uppercase text-stone-500 tracking-wider px-1">Recomendados</div>
                    <div class="space-y-2">
                      <div
                        v-for="(item, idx) in entities.slice(activeEntityIndex + 1, activeEntityIndex + 3).concat(entities.slice(0, 1))"
                        :key="idx"
                        @click="selectEntity(entities.indexOf(item))"
                        class="flex items-center justify-between p-2.5 rounded-lg bg-black/30 hover:bg-white/5 transition-colors cursor-pointer group"
                      >
                        <div class="flex items-center gap-2 min-w-0">
                          <img :src="item.image" class="w-7 h-7 rounded object-cover" alt="" />
                          <div class="flex flex-col min-w-0">
                            <span class="text-white text-xs font-semibold truncate group-hover:text-[#1DB954] transition-colors">{{ item.song }}</span>
                            <span class="text-stone-500 text-[10px] truncate">{{ item.name }}</span>
                          </div>
                        </div>
                        <Play class="h-3 w-3 text-stone-500 group-hover:text-white transition-colors" />
                      </div>
                    </div>
                  </div>
                </div>

                <!-- Bottom Floating Player Bar -->
                <div class="absolute bottom-16 left-3 right-3 bg-stone-900/90 rounded-xl p-2.5 flex items-center justify-between border border-white/5 shadow-2xl backdrop-blur-xl z-20">
                  <div class="flex items-center gap-2.5 min-w-0">
                    <div class="w-8 h-8 rounded bg-[#1DB954]/10 flex items-center justify-center overflow-hidden relative">
                      <img :src="entities[activeEntityIndex].image" class="w-full h-full object-cover" alt="" />
                    </div>
                    <div class="flex flex-col min-w-0">
                      <span class="text-white text-xs font-bold truncate leading-tight">{{ entities[activeEntityIndex].song }}</span>
                      <!-- Animated Equalizer if playing -->
                      <div v-if="isPlaying" class="flex gap-0.5 items-end h-2 mt-0.5">
                        <div class="w-0.5 bg-[#1DB954] rounded-full eq-bar-1"></div>
                        <div class="w-0.5 bg-[#1DB954] rounded-full eq-bar-2"></div>
                        <div class="w-0.5 bg-[#1DB954] rounded-full eq-bar-3"></div>
                      </div>
                      <span v-else class="text-stone-500 text-[9px] leading-tight">Pausado</span>
                    </div>
                  </div>
                  <div class="flex items-center gap-3 text-stone-400">
                    <Heart class="h-4 w-4 hover:text-[#1DB954] transition-colors cursor-pointer fill-transparent" />
                    <button @click="togglePlay" class="text-white focus:outline-none">
                      <Pause v-if="isPlaying" class="h-5 w-5 fill-white" />
                      <Play v-else class="h-5 w-5 fill-white" />
                    </button>
                  </div>
                </div>

                <!-- Bottom mock navigation -->
                <div class="absolute bottom-0 w-full h-16 bg-stone-950 flex justify-around items-center px-4 border-t border-white/5 z-20">
                  <div class="flex flex-col items-center text-[#1DB954]">
                    <Smartphone class="h-5 w-5" />
                    <span class="text-[9px] font-bold mt-0.5">Player</span>
                  </div>
                  <div class="flex flex-col items-center text-stone-500 hover:text-white transition-colors cursor-pointer" @click="scrollToSection('recursos')">
                    <BookOpen class="h-5 w-5" />
                    <span class="text-[9px] font-medium mt-0.5">Estudos</span>
                  </div>
                  <div class="flex flex-col items-center text-stone-500 hover:text-white transition-colors cursor-pointer" @click="scrollToSection('galeria')">
                    <Layers class="h-5 w-5" />
                    <span class="text-[9px] font-medium mt-0.5">Acervo</span>
                  </div>
                </div>
              </div>
            </div>

            <!-- Visual elements floating around mock -->
            <div class="absolute -top-6 -right-6 w-24 h-24 bg-[#1DB954]/10 rounded-full blur-xl pointer-events-none"></div>
            <div class="absolute -bottom-6 -left-6 w-32 h-32 bg-emerald-900/10 rounded-full blur-xl pointer-events-none"></div>
          </div>
        </div>
      </div>
    </section>

    <!-- Sobre o Aplicativo -->
    <section id="sobre" class="py-24 bg-[#121212] relative border-y border-white/5">
      <div class="max-w-4xl mx-auto px-6 text-center space-y-8">
        <span class="text-[#1DB954] font-black tracking-widest uppercase text-xs">Preservação Cultural</span>
        <h2 class="text-3xl md:text-5xl font-black font-sans text-white">Sobre o Aplicativo</h2>
        
        <div class="relative group p-8 md:p-12 rounded-3xl bg-black/40 border border-white/5 shadow-2xl overflow-hidden text-left">
          <!-- Background Glow Inside Card -->
          <div class="absolute inset-0 bg-gradient-to-br from-[#1DB954]/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500 pointer-events-none"></div>
          
          <div class="relative z-10 space-y-6 text-lg leading-relaxed text-stone-400">
            <p>
              O <strong class="text-white font-bold">FMA Pontos</strong> nasceu da necessidade de centralizar e organizar as letras dos pontos de Umbanda em um ambiente simples, acessível, rápido e respeitoso.
            </p>
            <p>
              Mais do que um player de música ou dicionário de letras, este projeto é uma forma de <strong class="text-[#1DB954] font-bold">preservação cultural</strong>, permitindo que praticantes e estudiosos tenham acesso rápido aos fundamentos sagrados, em qualquer lugar, diretamente no celular.
            </p>
            <p class="pt-4 border-t border-white/5 font-semibold text-white">
              O projeto não possui fins comerciais ou lucrativos, buscando puramente contribuir de forma aberta, respeitosa e acessível para toda a comunidade de axé.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Recursos / Bento Grid Features -->
    <section id="recursos" class="py-24 bg-black">
      <div class="max-w-7xl mx-auto px-6">
        <div class="text-center mb-16 space-y-4">
          <span class="text-[#1DB954] font-black tracking-widest uppercase text-xs">Recursos e Interface</span>
          <h2 class="text-3xl md:text-5xl font-black font-sans text-white">Feito para Ouvir e Sentir</h2>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 auto-rows-[250px]">
          <!-- Feature 1: Large Box -->
          <div class="md:col-span-2 rounded-3xl bg-[#121212] p-8 relative overflow-hidden group border border-white/5 hover:border-[#1DB954]/20 transition-all duration-300 flex flex-col justify-end">
            <!-- Large decorative icon background -->
            <div class="absolute top-4 right-4 text-[#1DB954] opacity-5 group-hover:opacity-15 transition-opacity transform group-hover:scale-110 duration-500 pointer-events-none">
              <BookOpen class="h-32 w-32" />
            </div>
            <div class="relative z-10 w-full md:w-3/4">
              <div class="w-12 h-12 rounded-full bg-[#1DB954]/10 flex items-center justify-center mb-4 text-[#1DB954]">
                <BookOpen class="h-6 w-6" />
              </div>
              <h3 class="text-2xl font-bold text-white mb-2">Consulta de Letras</h3>
              <p class="text-stone-400 text-sm leading-relaxed">
                Acesse o acervo completo de letras de pontos. Aprenda a cantar e estudar com precisão, guiado por uma interface limpa, focada no texto e com filtros rápidos.
              </p>
            </div>
          </div>

          <!-- Feature 2 -->
          <div class="rounded-3xl bg-[#121212] p-8 relative overflow-hidden group border border-white/5 hover:border-[#1DB954]/20 transition-all duration-300 flex flex-col justify-end">
            <div class="w-10 h-10 rounded-full bg-white/5 flex items-center justify-center mb-4 text-white group-hover:bg-[#1DB954] group-hover:text-black transition-all">
              <Layers class="h-5 w-5" />
            </div>
            <h3 class="text-xl font-bold text-white mb-2">Organização Inteligente</h3>
            <p class="text-stone-400 text-sm leading-relaxed">
              Conteúdos devidamente categorizados por Orixás, linhas e falanges. Encontre com facilidade o que precisa no momento de estudo.
            </p>
          </div>

          <!-- Feature 3 -->
          <div class="rounded-3xl bg-[#121212] p-8 relative overflow-hidden group border border-white/5 hover:border-[#1DB954]/20 transition-all duration-300 flex flex-col justify-end">
            <div class="w-10 h-10 rounded-full bg-white/5 flex items-center justify-center mb-4 text-white group-hover:bg-[#1DB954] group-hover:text-black transition-all">
              <Sparkles class="h-5 w-5" />
            </div>
            <h3 class="text-xl font-bold text-white mb-2">Interface Premium</h3>
            <p class="text-stone-400 text-sm leading-relaxed">
              Design inspirado nas melhores plataformas de streaming de música. Visual moderno e escuro, perfeito para uso noturno sem fadiga ocular.
            </p>
          </div>

          <!-- Feature 4: Large Horizontal -->
          <div class="md:col-span-2 rounded-3xl bg-[#121212] p-8 relative overflow-hidden group border border-white/5 hover:border-[#1DB954]/20 transition-all duration-300 flex items-center">
            <!-- Large decorative icon background -->
            <div class="absolute top-4 right-4 text-[#1DB954] opacity-5 group-hover:opacity-15 transition-opacity transform group-hover:scale-110 duration-500 pointer-events-none">
              <Music class="h-32 w-32" />
            </div>
            <div class="flex-1 z-10 relative">
              <div class="w-12 h-12 rounded-full bg-[#1DB954]/10 flex items-center justify-center mb-4 text-[#1DB954]">
                <Music class="h-6 w-6" />
              </div>
              <h3 class="text-2xl font-bold text-white mb-2">Player Integrado</h3>
              <p class="text-stone-400 text-sm leading-relaxed max-w-md">
                Ouça o áudio e guias dos pontos ao mesmo tempo em que lê as letras. Excelente para compreender a melodia, a cadência e o toque correspondente do atabaque.
              </p>
            </div>
            <!-- Interactive decorative visualizer -->
            <div class="hidden md:flex gap-1 h-12 items-end opacity-40 pr-6">
              <div class="w-2.5 bg-[#1DB954] rounded-full h-12 animate-[bounce_1s_infinite]"></div>
              <div class="w-2.5 bg-[#1DB954] rounded-full h-8 animate-[bounce_1.2s_infinite_0.1s]"></div>
              <div class="w-2.5 bg-[#1DB954] rounded-full h-10 animate-[bounce_0.9s_infinite_0.2s]"></div>
              <div class="w-2.5 bg-[#1DB954] rounded-full h-6 animate-[bounce_1.5s_infinite_0.3s]"></div>
              <div class="w-2.5 bg-[#1DB954] rounded-full h-12 animate-[bounce_1.1s_infinite_0.4s]"></div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Galeria e Espiritualidade Section -->
    <section id="galeria" class="py-24 bg-[#121212] overflow-hidden border-t border-white/5">
      <div class="max-w-7xl mx-auto px-6">
        <div class="flex flex-col md:flex-row justify-between items-end gap-6 mb-12">
          <div class="space-y-4">
            <span class="text-[#1DB954] font-black tracking-widest uppercase text-xs">Acervo Visual</span>
            <h2 class="text-3xl md:text-5xl font-black font-sans text-white">Galeria e Espiritualidade</h2>
            <p class="text-stone-400 text-lg max-w-2xl">
              Navegue pelas falanges e divindades.
            </p>
          </div>
          <!-- Gallery Controls -->
          <div class="flex gap-3">
            <button
              @click="scrollGallery('left')"
              class="w-12 h-12 rounded-full bg-black/60 hover:bg-[#121212] border border-white/5 flex items-center justify-center text-white hover:text-[#1DB954] hover:border-[#1DB954]/30 transition-all cursor-pointer"
              aria-label="Rolar para esquerda"
            >
              <ChevronLeft class="h-6 w-6" />
            </button>
            <button
              @click="scrollGallery('right')"
              class="w-12 h-12 rounded-full bg-black/60 hover:bg-[#121212] border border-white/5 flex items-center justify-center text-white hover:text-[#1DB954] hover:border-[#1DB954]/30 transition-all cursor-pointer"
              aria-label="Rolar para direita"
            >
              <ChevronRight class="h-6 w-6" />
            </button>
          </div>
        </div>

        <!-- Horizontal scroll row -->
        <div
          ref="galleryScrollContainer"
          class="flex gap-6 overflow-x-auto pb-8 snap-x snap-mandatory scrollbar-none"
          style="scrollbar-width: none;"
        >
          <div
            v-for="(entity, index) in entities"
            :key="entity.name"
            @click="selectEntity(index)"
            class="min-w-[280px] md:min-w-[320px] aspect-[4/5] rounded-3xl overflow-hidden relative group snap-start cursor-pointer border border-white/5 hover:border-[#1DB954]/30 transition-all duration-300"
          >
            <!-- Zoom Image effect -->
            <img
              :src="entity.image"
              :alt="entity.name"
              class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-105"
            />
            <!-- Dark Gradient overlay -->
            <div
              class="absolute inset-0 bg-gradient-to-t from-black via-black/40 to-transparent transition-opacity duration-300"
              :class="activeEntityIndex === index ? 'opacity-90' : 'opacity-80 group-hover:opacity-75'"
            ></div>

            <!-- Content -->
            <div class="absolute bottom-6 left-6 right-6 flex items-end justify-between">
              <div class="space-y-1">
                <span class="text-[#1DB954] text-xs font-bold tracking-wider uppercase">{{ entity.subtitle }}</span>
                <h3 class="text-2xl font-black text-white leading-tight">{{ entity.name }}</h3>
                <p class="text-stone-300 text-xs truncate max-w-[180px]">{{ entity.song }}</p>
              </div>

              <!-- Animated music equalizer or play button on state -->
              <div class="w-10 h-10 rounded-full bg-[#1DB954] text-black flex items-center justify-center shadow-lg transform translate-y-2 opacity-0 group-hover:translate-y-0 group-hover:opacity-100 transition-all duration-300">
                <Volume2 v-if="activeEntityIndex === index && isPlaying" class="h-5 w-5 animate-pulse" />
                <Play v-else class="h-5 w-5 fill-black ml-0.5" />
              </div>
            </div>

            <!-- Selection highlight border -->
            <div
              class="absolute inset-0 border-2 rounded-3xl pointer-events-none transition-all duration-300"
              :class="activeEntityIndex === index ? 'border-[#1DB954] shadow-[inset_0_0_20px_rgba(29,185,84,0.3)]' : 'border-transparent'"
            ></div>
          </div>
        </div>
      </div>
    </section>

    <!-- Download Section -->
    <section id="download" class="py-24 bg-black relative overflow-hidden">
      <!-- Ambient Glow behind CTA -->
      <div class="absolute inset-0 flex items-center justify-center pointer-events-none">
        <div class="w-[600px] h-[300px] bg-[#1DB954]/10 rounded-full blur-[120px]"></div>
      </div>

      <div class="container mx-auto max-w-4xl px-6 relative z-10">
        <div class="bg-[#121212] rounded-[40px] p-8 md:p-16 text-center border border-white/10 shadow-2xl relative overflow-hidden">
          <div class="absolute top-0 left-0 w-full h-[3px] bg-gradient-to-r from-transparent via-[#1DB954] to-transparent opacity-55"></div>
          
          <h2 class="text-4xl md:text-5xl font-black font-sans text-white mb-6">Pronto para começar?</h2>
          <p class="text-stone-400 text-lg mb-10 max-w-xl mx-auto leading-relaxed">
            Baixe a versão estável mais recente para Android e tenha os pontos de Umbanda organizados na palma da sua mão.
          </p>

          <div v-if="loading" class="flex flex-col items-center justify-center py-10 text-stone-400">
            <Loader2 class="mb-4 h-10 w-10 animate-spin text-[#1DB954]" />
            <p class="font-medium">Procurando no acervo do GitHub...</p>
          </div>

          <div v-else-if="error || !latestRelease" class="mx-auto max-w-md rounded-2xl border border-white/5 bg-black/40 py-8 px-6">
            <Smartphone class="mx-auto mb-4 h-10 w-10 text-stone-600" />
            <p class="mb-6 font-semibold text-white">
              O download direto está indisponível temporariamente.
            </p>
            <a
              href="https://github.com/Rdinda/FMA_Pontos/releases"
              target="_blank"
              rel="noopener noreferrer"
              class="inline-flex items-center justify-center gap-2 rounded-full border border-white/10 bg-white/5 px-8 py-3.5 font-bold text-white transition-all hover:bg-white/10"
            >
              <Github class="h-5 w-5" />
              Acessar GitHub Releases
            </a>
          </div>

          <div v-else class="flex flex-col items-center space-y-6">
            <div class="inline-flex items-center gap-2 rounded-full border border-[#1DB954]/20 bg-[#1DB954]/10 px-4 py-1.5 text-xs font-black text-[#1DB954] uppercase tracking-wider">
              <span class="h-2 w-2 animate-pulse rounded-full bg-[#1DB954]"></span>
              Versão {{ latestRelease.tag_name }} ativa
            </div>

            <div class="flex w-full flex-col justify-center gap-4 sm:flex-row">
              <a
                v-if="latestRelease.assets?.[0]?.browser_download_url"
                :href="latestRelease.assets[0].browser_download_url"
                class="inline-flex items-center justify-center gap-3 rounded-full bg-[#1DB954] hover:bg-[#1ed760] px-10 py-4.5 text-lg font-black text-black shadow-lg transition-all hover:-translate-y-0.5 hover:scale-105 hover:shadow-[0_0_30px_rgba(29,185,84,0.4)]"
              >
                <Download class="h-6 w-6" />
                Baixar APK para Android
              </a>
              <a
                v-else
                :href="latestRelease.html_url"
                target="_blank"
                rel="noopener noreferrer"
                class="inline-flex items-center justify-center gap-3 rounded-full bg-[#1DB954] hover:bg-[#1ed760] px-10 py-4.5 text-lg font-black text-black shadow-lg transition-all hover:-translate-y-0.5 hover:scale-105"
              >
                <Github class="h-6 w-6" />
                Baixar no GitHub
              </a>
            </div>

            <p class="text-xs text-stone-500 font-medium">Livre de anúncios • Código aberto • APK seguro</p>

            <div class="w-full flex justify-center pt-6">
              <ReleaseNotes :body="latestRelease.body" />
            </div>

            <div v-if="pastReleases.length > 0" class="pt-4 text-sm text-stone-400">
              <a
                href="https://github.com/Rdinda/FMA_Pontos/releases"
                target="_blank"
                rel="noopener noreferrer"
                class="underline decoration-[#1DB954] underline-offset-4 transition hover:text-[#1DB954] font-semibold"
              >
                Ver versões anteriores
              </a>
            </div>
          </div>
        </div>

        <div class="mt-12 text-center">
          <a
            href="https://github.com/Rdinda/FMA_Pontos"
            target="_blank"
            rel="noopener noreferrer"
            class="inline-flex items-center gap-2 text-sm text-stone-500 transition hover:text-white"
          >
            <Github class="h-4 w-4" />
            Ver Código Fonte no GitHub
          </a>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="bg-black border-t border-white/5 pt-16 pb-8">
      <div class="max-w-7xl mx-auto px-6">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-12 mb-12">
          <!-- Brand Info -->
          <div class="col-span-1 md:col-span-2 space-y-4">
            <div class="flex items-center gap-3">
              <img
                src="/imagens/emblema_semfundo.png"
                alt=""
                aria-hidden="true"
                class="h-8 w-8 opacity-90 filter drop-shadow-[0_0_8px_rgba(29,185,84,0.3)]"
                width="32"
                height="32"
              />
              <span class="text-xl font-headline font-black text-white">FMA Pontos</span>
            </div>
            <p class="text-sm text-stone-400 max-w-md leading-relaxed font-medium">
              Um projeto independente voltado à preservação cultural da Umbanda. Auxiliando no estudo das cantigas sagradas com respeito e seriedade aos rituais.
            </p>
          </div>
          
          <!-- Quick Links -->
          <div>
            <h4 class="text-white font-bold mb-4 text-xs uppercase tracking-wider">Projeto</h4>
            <ul class="space-y-3">
              <li>
                <a href="https://github.com/Rdinda/FMA_Pontos" target="_blank" class="text-sm text-stone-400 hover:text-[#1DB954] transition-colors">
                  Sobre Nós
                </a>
              </li>
              <li>
                <a href="https://github.com/Rdinda/FMA_Pontos" target="_blank" class="text-sm text-stone-400 hover:text-[#1DB954] transition-colors">
                  Código Fonte
                </a>
              </li>
              <li>
                <a href="https://github.com/Rdinda/FMA_Pontos/issues" target="_blank" class="text-sm text-stone-400 hover:text-[#1DB954] transition-colors">
                  Reportar Problema
                </a>
              </li>
            </ul>
          </div>
          
          <!-- Legal info -->
          <div>
            <h4 class="text-white font-bold mb-4 text-xs uppercase tracking-wider">Aviso Legal</h4>
            <p class="text-xs text-stone-500 italic leading-relaxed">
              Este aplicativo não possui vínculo institucional com terreiros, federações ou ordens específicas. Trata-se de uma ferramenta independente de difusão de letras.
            </p>
          </div>
        </div>

        <div class="border-t border-white/5 pt-8 flex flex-col md:flex-row items-center justify-between gap-4">
          <p class="text-xs text-stone-500 font-semibold">
            © 2026 FMA Pontos. Axé. Todos os direitos reservados.
          </p>
          <div class="flex gap-4">
            <a
              href="https://github.com/Rdinda/FMA_Pontos"
              target="_blank"
              rel="noopener noreferrer"
              class="w-8 h-8 rounded-full bg-white/5 flex items-center justify-center text-stone-400 hover:text-white hover:bg-white/10 transition-all"
            >
              <Github class="h-4 w-4" />
            </a>
          </div>
        </div>
      </div>
    </footer>
  </div>
</template>

<style scoped>
@keyframes eqBar {
  0%, 100% { height: 4px; }
  50% { height: 16px; }
}
.eq-bar-1 { animation: eqBar 0.8s infinite ease-in-out; }
.eq-bar-2 { animation: eqBar 1.1s infinite ease-in-out 0.25s; }
.eq-bar-3 { animation: eqBar 0.9s infinite ease-in-out 0.45s; }

/* Custom Hide Scrollbar classes */
.scrollbar-none::-webkit-scrollbar {
  display: none;
}
.scrollbar-none {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
</style>
