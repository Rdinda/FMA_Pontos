<script setup lang="ts">
import { ref } from 'vue';
import { Zap, Copy, Check } from 'lucide-vue-next';

const props = defineProps<{
  body: string;
}>();

const copied = ref(false);

const handleCopy = async () => {
    try {
        await navigator.clipboard.writeText(props.body);
        copied.value = true;
        setTimeout(() => (copied.value = false), 2000);
    } catch (err) {
        console.error('Failed to copy:', err);
    }
};

const formatBody = (text: string) => {
    // Remove "Full Changelog" text but keep the URL
    const filteredText = text
        .replace(/\*?\*?Full Changelog\*?\*?:?\s*/gi, '')
        .trim();

    // Regex to match URLs
    const urlRegex = /(https?:\/\/[^\s]+)/g;

    const parts = filteredText.split(urlRegex);
    
    return parts;
};

const isUrl = (text: string) => {
    return /^https?:\/\/[^\s]+$/.test(text);
};

const truncateUrl = (url: string) => {
    return url.length > 50 ? url.substring(0, 47) + '...' : url;
};
</script>

<template>
  <div class="w-full max-w-2xl overflow-hidden rounded-xl border border-stone-200 bg-stone-100 p-4 text-left sm:p-6 dark:border-stone-800/50 dark:bg-[#151312]">
      <div class="mb-3 flex items-center justify-between">
          <h3 class="flex items-center gap-2 font-semibold text-stone-800 dark:text-stone-200">
              <Zap class="h-4 w-4 text-gold" />
              Novidades desta versão
          </h3>
          <button
              @click="handleCopy"
              class="flex items-center gap-1.5 rounded-lg bg-stone-200 px-2.5 py-1.5 text-xs font-medium text-stone-600 transition-all hover:bg-stone-300 hover:text-stone-800 dark:bg-stone-800 dark:text-stone-400 dark:hover:bg-stone-700 dark:hover:text-stone-200"
              title="Copiar notas de lançamento"
          >
              <template v-if="copied">
                  <Check class="h-3.5 w-3.5 text-green-500" />
                  <span class="hidden sm:inline">Copiado!</span>
              </template>
              <template v-else>
                  <Copy class="h-3.5 w-3.5" />
                  <span class="hidden sm:inline">Copiar</span>
              </template>
          </button>
      </div>
      <div class="max-w-full overflow-x-auto font-mono text-sm leading-relaxed break-words whitespace-pre-wrap text-stone-600 dark:text-stone-400">
          <template v-for="(part, index) in formatBody(body)" :key="index">
              <a
                  v-if="isUrl(part)"
                  :href="part"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="break-all text-gold hover:underline"
                  :title="part"
              >
                  {{ truncateUrl(part) }}
              </a>
              <span v-else>{{ part }}</span>
          </template>
      </div>
  </div>
</template>
