<script setup lang="ts">

defineProps<{
  title: string;
  description: string;
}>();
</script>

<template>
  <div
    class="group w-full max-w-[220px] rounded-card border border-stone-200 bg-white p-6 text-left shadow-sm transition-all hover:-translate-y-1 hover:border-gold/30 hover:shadow-md dark:border-stone-800 dark:bg-[#151312]"
  >
    <div
      class="mb-4 inline-flex rounded-button border border-stone-100 bg-cream p-3 transition-colors group-hover:border-gold/20 dark:border-stone-800 dark:bg-[#1C1917]"
    >
      <slot name="icon"></slot>
    </div>
    <h3 class="mb-2 font-sans text-base font-bold text-fma-text dark:text-white">
      {{ title }}
    </h3>
    <p class="text-sm leading-relaxed text-fma-muted dark:text-stone-400">
      {{ description }}
    </p>
  </div>
</template>
