<script lang="ts">
	/**
	 * VideoEmbed Component - DIYK9 Landing Page
	 * YouTube video embeds with modal and CTA
	 */

	interface Props {
		videoId: string;
		title: string;
		autoplay?: boolean;
		muted?: boolean;
		isModal?: boolean;
		ctaText?: string;
		ctaLink?: string;
		onClose?: () => void;
	}

	let {
		videoId,
		title,
		autoplay = false,
		muted = true,
		isModal = false,
		ctaText = '',
		ctaLink = '',
		onClose
	}: Props = $props();

	let isPlaying = $state(autoplay);

	// Construct YouTube embed URL with parameters
	const embedUrl = $derived.by(() => {
		const params = new URLSearchParams({
			autoplay: isPlaying ? '1' : '0',
			mute: muted ? '1' : '0',
			rel: '0',
			modestbranding: '1',
			playsinline: '1',
			controls: '1'
		});

		return `https://www.youtube.com/embed/${videoId}?${params.toString()}`;
	});

	const thumbnailUrl = $derived(`https://img.youtube.com/vi/${videoId}/maxresdefault.jpg`);

	function handlePlay() {
		isPlaying = true;
	}

	function handleClose() {
		isPlaying = false;
		onClose?.();
	}
</script>

{#if isModal}
	<!-- Modal Version -->
	<div class="modal-video-container">
		<iframe
			src={embedUrl}
			{title}
			frameborder="0"
			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
			allowfullscreen
		></iframe>
	</div>
	{#if ctaText && ctaLink}
		<div class="modal-cta-section">
			<p class="modal-cta-text">
				{ctaText}
			</p>
			<a href={ctaLink} class="btn btn-primary" target="_blank" rel="noopener">
				Enroll Now
				<span class="btn-glow"></span>
			</a>
		</div>
	{/if}
{:else}
	<!-- Thumbnail Version -->
	<!-- svelte-ignore a11y_no_static_element_interactions -->
	<!-- svelte-ignore a11y_click_events_have_key_events -->
	<div
		class="video-wrapper"
		onclick={handlePlay}
		role="button"
		tabindex="0"
	>
		<img src={thumbnailUrl} alt={title} class="thumbnail" />
		<div class="play-button" role="button" tabindex="0" aria-label="Play video">
			<svg viewBox="0 0 24 24" fill="currentColor" width="28" height="28">
				<path d="M8 5v14l11-7z" />
			</svg>
		</div>
	</div>
{/if}

<style>
	.video-wrapper {
		position: relative;
		width: 100%;
		height: 100%;
		cursor: pointer;
		overflow: hidden;
	}

	.thumbnail {
		width: 100%;
		height: 100%;
		object-fit: cover;
		transition: transform 0.5s ease, filter 0.3s ease;
		filter: brightness(0.85);
	}

	.video-wrapper:hover .thumbnail {
		transform: scale(1.05);
		filter: brightness(1);
	}

	.play-button {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		width: 70px;
		height: 70px;
		background: rgba(193, 17, 47, 0.9);
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;
		transition: all 0.3s ease;
		box-shadow: 0 0 30px rgba(193, 17, 47, 0.5);
		color: white;
	}

	.play-button:hover {
		transform: translate(-50%, -50%) scale(1.1);
		background: #C1112F;
		box-shadow: 0 0 50px rgba(193, 17, 47, 0.7);
	}

	.play-button svg {
		width: 28px;
		height: 28px;
		fill: white;
		margin-left: 4px;
	}

	.modal-video-container {
		position: relative;
		padding-bottom: 56.25%;
		height: 0;
		background: #000;
	}

	.modal-video-container iframe {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		border: none;
	}

	.modal-cta-section {
		padding: 2rem;
		background: #0a0a0a;
		border-top: 1px solid rgba(255, 255, 255, 0.05);
		text-align: center;
	}

	.modal-cta-text {
		font-size: 1.1rem;
		color: #d4d4d4;
		margin-bottom: 1rem;
		line-height: 1.6;
	}

	.modal-cta-text strong {
		color: #C1112F;
		font-weight: 600;
	}

	.btn {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		gap: 0.5rem;
		padding: 1rem 2rem;
		font-family: 'Oswald', sans-serif;
		font-size: 0.95rem;
		font-weight: 600;
		letter-spacing: 1.5px;
		text-transform: uppercase;
		text-decoration: none;
		border-radius: 8px;
		transition: all 0.3s ease;
		cursor: pointer;
		border: none;
		position: relative;
		overflow: hidden;
	}

	.btn-primary {
		background: #C1112F;
		color: #fff;
		box-shadow: 0 0 40px rgba(193, 17, 47, 0.3);
	}

	.btn-primary:hover {
		background: #8B0D22;
		transform: translateY(-3px);
		box-shadow: 0 10px 40px rgba(193, 17, 47, 0.5);
	}

	.btn-glow {
		position: absolute;
		inset: -2px;
		background: linear-gradient(135deg, #C1112F, #E11D3C);
		border-radius: inherit;
		z-index: -1;
		opacity: 0;
		transition: opacity 0.3s ease;
		filter: blur(10px);
	}

	.btn:hover .btn-glow {
		opacity: 0.5;
	}

	@media (max-width: 768px) {
		.play-button {
			width: 50px;
			height: 50px;
		}

		.play-button svg {
			width: 20px;
			height: 20px;
		}
	}
</style>
