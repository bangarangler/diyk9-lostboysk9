<script lang="ts">
	import { browser } from '$app/environment';
	import { onMount } from 'svelte';
	import VideoEmbed from '$lib/components/VideoEmbed.svelte';
	
	let scrolled = $state(false);
	let activeModal = $state<string | null>(null);
	let isLostBoysTheme = $state(false);
	let currentReview = $state(0);
	let reviewInterval: ReturnType<typeof setInterval> | null = null;
	
	interface Course {
		id: string;
		tag: string;
		title: string;
		description: string;
		price: string;
		videoId: string;
		link: string;
		features: string[];
		modalCta: string;
	}
	
	const courses: Course[] = [
		{
			id: 'complete',
			tag: 'Best Value',
			title: 'Complete Training Set',
			description: 'The ultimate toolkit for K9 mastery. Zero to Hero with ALL courses plus industry-leading support.',
			price: '$797',
			videoId: 'u9cdd4G79Ms',
			link: 'https://www.diyk9.com/a/2147834112/ozD5mSCE',
			features: [
				'All DIYK9 courses included',
				'20+ hours of professional instruction',
				'Lifetime access to all content',
				'Industry-leading training support',
				'30-day money-back guarantee'
			],
			modalCta: 'Get the complete system used by 100,000+ dog owners'
		},
		{
			id: 'puppy',
			tag: 'Foundation',
			title: 'Puppy Essentials',
			description: 'The ultimate toolkit for shaping the perfect puppy. Navigate puppyhood with confidence.',
			price: '$297',
			videoId: '_IVbzeJrIHw',
			link: 'https://www.diyk9.com/a/2147531877/ozD5mSCE',
			features: [
				'Potty training mastery',
				'Crate training comfort',
				'Stop nipping & biting',
				'Basic manners & boundaries',
				'20+ hours of instruction'
			],
			modalCta: 'Transform your puppy into the perfect companion'
		},
		{
			id: 'obedience',
			tag: 'Core Skills',
			title: 'Obedience 101',
			description: 'Master sit, stay, come, down, and heel. The foundation of a well-behaved dog.',
			price: '$197',
			videoId: '3kfIuJMnDQs',
			link: 'https://www.diyk9.com/a/2147531878/ozD5mSCE',
			features: [
				'Complete obedience commands',
				'Real-world reliability',
				'Professional handler methods',
				'Step-by-step guidance',
				'Lifetime access'
			],
			modalCta: 'Build rock-solid obedience in weeks, not months'
		},
		{
			id: 'walk',
			tag: 'Leash Skills',
			title: 'The Perfect Walk',
			description: 'Stop pulling, lunging, and leash reactivity. Transform walks from stressful to enjoyable.',
			price: '$147',
			videoId: 'lPJktGiRMCg',
			link: 'https://www.diyk9.com/a/2147531879/ozD5mSCE',
			features: [
				'Eliminate leash pulling',
				'Stop lunging & reactivity',
				'Loose leash walking',
				'Confidence on walks',
				'Professional techniques'
			],
			modalCta: 'Enjoy peaceful walks with your dog again'
		},
		{
			id: 'unleashed',
			tag: 'Advanced',
			title: 'Unleashed',
			description: 'Off-leash reliability and advanced obedience. Build trust and control without a leash.',
			price: '$247',
			videoId: 'Outorlr6o4Y',
			link: 'https://www.diyk9.com/a/2147531880/ozD5mSCE',
			features: [
				'Off-leash recall mastery',
				'Advanced distance commands',
				'Real-world reliability',
				'Build unbreakable trust',
				'Police K9 techniques'
			],
			modalCta: 'Give your dog freedom while maintaining control'
		},
		{
			id: 'behavior',
			tag: 'Behavior',
			title: 'Behavior Solutions',
			description: 'Address reactivity, aggression, and problem behaviors. Specialized protocols for challenging dogs.',
			price: '$297',
			videoId: 'LuU9Qxe2rUg',
			link: 'https://www.diyk9.com/a/2147531882/ozD5mSCE',
			features: [
				'Reactivity protocols',
				'Aggression management',
				'Behavior modification',
				'Anxiety solutions',
				'Expert guidance included'
			],
			modalCta: 'Transform problem behaviors into confident obedience'
		}
	];
	
	const reviews = [
		{
			name: 'Aaron & Delilah',
			dog: 'Delilah',
			course: 'Unleashed',
			text: "Experience the impact of Aaron's commitment to excellence and his dedication to the Unleashed course, leading to extraordinary changes with his dog Delilah in just 8 weeks.",
			rating: 5
		},
		{
			name: 'Andrea & Ranger',
			dog: 'Ranger',
			course: 'The Perfect Walk',
			text: "Watch how Andrea mastered The Perfect Walk, resulting in an unbreakable bond with her dog, Ranger. The transformation was incredible.",
			rating: 5
		},
		{
			name: 'Andre & Saluki',
			dog: 'Saluki',
			course: 'The Perfect Walk',
			text: "Discover how Andre overcame leash reactivity with his dog, Saluki. Aimed at individuals lacking prior dog training experience, this program provided outstanding results within just a week.",
			rating: 5
		}
	];
	
	function startReviewRotation() {
		reviewInterval = setInterval(() => {
			currentReview = (currentReview + 1) % reviews.length;
		}, 5000);
	}
	
	function stopReviewRotation() {
		if (reviewInterval) {
			clearInterval(reviewInterval);
			reviewInterval = null;
		}
	}
	
	function goToReview(index: number) {
		stopReviewRotation();
		currentReview = index;
		startReviewRotation();
	}
	
	function nextReview() {
		stopReviewRotation();
		currentReview = (currentReview + 1) % reviews.length;
		startReviewRotation();
	}
	
	function prevReview() {
		stopReviewRotation();
		currentReview = (currentReview - 1 + reviews.length) % reviews.length;
		startReviewRotation();
	}
	
	onMount(() => {
		if (browser) {
			const handleScroll = () => {
				scrolled = window.scrollY > 50;
			};
			window.addEventListener('scroll', handleScroll);
			
			document.querySelectorAll('a[href^="#"]').forEach(anchor => {
				anchor.addEventListener('click', (e) => {
					e.preventDefault();
					const href = anchor.getAttribute('href');
					if (href) {
						const element = document.querySelector(href);
						element?.scrollIntoView({ behavior: 'smooth' });
					}
				});
			});
			
			startReviewRotation();
			
			return () => {
				window.removeEventListener('scroll', handleScroll);
				stopReviewRotation();
			};
		}
	});
	
	function openModal(courseId: string) {
		activeModal = courseId;
		document.body.style.overflow = 'hidden';
	}
	
	function closeModal() {
		activeModal = null;
		document.body.style.overflow = '';
	}
	
	function toggleTheme() {
		isLostBoysTheme = !isLostBoysTheme;
	}
	
	function handleKeydown(event: KeyboardEvent) {
		if (event.key === 'Escape') {
			closeModal();
		}
	}
</script>

<svelte:head>
	<title>DIY K9 Training - Lost Boys K9 Academy Affiliate</title>
	<meta name="description" content="Certified ASK9 trainer recommends DIYK9. Professional online dog training by Garret Wing. Use code LOSTBOYSK9 for 10% off." />
</svelte:head>

<svelte:window on:keydown={handleKeydown} />

<!-- Navigation -->
<nav class="nav" class:nav-scrolled={scrolled}>
	<div class="nav-container">
		<a href="/" class="logo">
			<span class="logo-main">DIY<span class="logo-accent">K9</span></span>
		</a>
		
		<div class="nav-cta">
			<div class="ask9-badge">
				<span class="ask9-text">ASK9 Certified</span>
			</div>
			<a href="#signup" class="btn btn-primary" style="padding: 0.75rem 1.5rem; font-size: 0.85rem;">
				Get 10% Off
			</a>
		</div>
	</div>
</nav>

<main>
	<!-- Hero Section with Autoplay Video -->
	<section class="hero" id="hero">
		<div class="hero-video-bg">
			<div style="position: absolute; inset: 0;">
				<iframe
					src="https://www.youtube.com/embed/gRGmMqhVRPA?autoplay=1&mute=1&loop=1&playlist=gRGmMqhVRPA&rel=0&modestbranding=1&playsinline=1&controls=0"
					title="Meet Jon & The Pack"
					frameborder="0"
					allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
					allowfullscreen
					style="width: 100%; height: 100%; object-fit: cover;"
				></iframe>
			</div>
		</div>
		
		<div class="hero-content">
			<h1 class="hero-title">
				<span class="hero-title-line1">Train Your Dog</span>
				<span class="hero-title-line2">Like A Pro</span>
			</h1>
			
			<p class="hero-subtitle">
				Hi, I'm <strong>Jon Palacio</strong> from Lost Boys K9 Academy. 
				I trained under <strong>Garret Wing</strong> and recommend DIYK9 
				as the affordable path to professional results.
			</p>
			
			<div class="hero-cta-group">
				<a href="https://www.diyk9.com/a/2147834112/ozD5mSCE" class="btn btn-primary" target="_blank" rel="noopener">
					Get Complete Training Set
					<span class="btn-glow"></span>
				</a>
				<a href="#signup" class="btn btn-secondary">
					Get 10% Off Code
				</a>
			</div>
		</div>
	</section>

	<!-- Stats Bar - DIYK9 Numbers -->
	<div class="stats-bar">
		<div class="stat">
			<span class="stat-value">9M+</span>
			<span class="stat-label">Social Followers</span>
		</div>
		<div class="stat">
			<span class="stat-value">100K+</span>
			<span class="stat-label">Dogs Helped</span>
		</div>
		<div class="stat">
			<span class="stat-value">Results</span>
			<span class="stat-label">After First Session</span>
		</div>
	</div>

	<!-- Courses Section -->
	<section class="section" id="courses">
		<div class="container">
			<div class="section-header">
				<span class="section-label">Garret Wing's Programs</span>
				<h2 class="section-title">Professional Training At Home</h2>
				<p class="section-subtitle">
					These are the exact courses I recommend to clients who want professional 
					results but need a budget-friendly option. Use code <strong style="color: #C1112F;">LOSTBOYSK9</strong>.
				</p>
			</div>
			
			<div class="courses-grid">
				{#each courses as course}
					<!-- svelte-ignore a11y_click_events_have_key_events -->
					<!-- svelte_ignore a11y_no_static_element_interactions -->
					<div class="course-card" onclick={() => openModal(course.id)} role="button" tabindex="0">
						<div class="course-video-thumb">
							<VideoEmbed 
								videoId={course.videoId} 
								title={course.title}
								autoplay={false}
								muted={true}
							/>
						</div>
						<div class="course-content">
							<span class="course-tag">{course.tag}</span>
							<h3 class="course-title">{course.title}</h3>
							<p class="course-description">{course.description}</p>
							<div class="course-footer">
								<span class="course-price">View Pricing</span>
								<button class="btn btn-primary course-btn" onclick={() => {}}>
									Watch Preview
								</button>
							</div>
						</div>
					</div>
				{/each}
			</div>
		</div>
	</section>

	<!-- Testimonials Section with Carousel -->
	<section class="section testimonials-section" id="proof">
		<div class="container">
			<div class="section-header">
				<span class="section-label">Real Results</span>
				<h2 class="section-title">What Dog Owners Say</h2>
			</div>
			
			<div class="testimonial-carousel">
				<button class="carousel-arrow prev" onclick={prevReview} aria-label="Previous review">
					<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
						<path d="M15 18l-6-6 6-6"/>
					</svg>
				</button>
				
				<div class="carousel-container">
					<div class="carousel-track" style="transform: translateX(-{currentReview * 100}%)">
						{#each reviews as review}
							<div class="testimonial-card">
								<div class="testimonial-stars">
									{#each Array(review.rating) as _}
										<span class="testimonial-star">★</span>
									{/each}
								</div>
								<p class="testimonial-text">{review.text}</p>
								<div class="testimonial-author">{review.name}</div>
								<div class="testimonial-role">{review.dog} • {review.course}</div>
							</div>
						{/each}
					</div>
				</div>
				
				<button class="carousel-arrow next" onclick={nextReview} aria-label="Next review">
					<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
						<path d="M9 18l6-6-6-6"/>
					</svg>
				</button>
				
				<div class="carousel-dots">
					{#each reviews as _, index}
						<button 
							class="carousel-dot {index === currentReview ? 'active' : ''}" 
							onclick={() => goToReview(index)}
							aria-label="Go to review {index + 1}"
						></button>
					{/each}
				</div>
			</div>
		</div>
	</section>

	<!-- Email Capture Section -->
	<section class="section capture-section" id="signup">
		<div class="capture-container">
			<span class="section-label">Exclusive Offer</span>
			<h2 class="section-title" style="margin-bottom: var(--space-sm);">Get 10% Off Your First Course</h2>
			<p class="section-subtitle">
				Join my email list for training tips and receive code <strong style="color: #C1112F;">LOSTBOYSK9</strong> 
				for 10% off your first DIYK9 purchase.
			</p>
			
			<form class="capture-form" method="POST">
				<input 
					type="email" 
					class="capture-input" 
					placeholder="Enter your email" 
					required
				/>
				<button type="submit" class="btn btn-primary">
					Get My Code
					<span class="btn-glow"></span>
				</button>
			</form>
			
			<p style="font-size: 0.85rem; color: var(--color-gray-500); margin-top: var(--space-md);">
				No spam. Unsubscribe anytime. Your information is secure.
			</p>
		</div>
	</section>

	<!-- Upsell Banner -->
	<section class="upsell-banner">
		<div class="upsell-content">
			<h2 class="upsell-title">Want Hands-Off Results?</h2>
			<p class="upsell-text">
				If DIY isn't for you, I offer professional Board & Train programs at Lost Boys K9 Academy 
				with lifetime support and guaranteed results.
			</p>
			<a href="https://lostboysk9academy.com/contact" class="btn btn-secondary" style="border-color: white; background: rgba(255,255,255,0.1);">
				Book a Consultation
			</a>
		</div>
	</section>
</main>

<!-- Footer with Theme Toggle -->
<footer class="footer" class:lost-boys-theme={isLostBoysTheme}>
	<div class="footer-container">
		<div class="footer-brand-box">
			<p class="footer-brand-name">{isLostBoysTheme ? 'Lost Boys K9 Academy' : 'DIYK9 Affiliate'}</p>
		</div>
		
		<div class="footer-ask9-badge">
			<span class="footer-ask9-text">ASK9 Certified Trainer</span>
		</div>
		
		<div class="footer-social-icons">
			<a href="https://www.instagram.com/lostboysk9academy/" target="_blank" rel="noopener noreferrer" class="footer-social-link instagram" aria-label="Instagram">
				<svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
					<path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/>
				</svg>
			</a>
			<a href="https://www.facebook.com/people/Lost-Boys-K9-Academy/61562245678485/" target="_blank" rel="noopener noreferrer" class="footer-social-link facebook" aria-label="Facebook">
				<svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
					<path d="M9 8h-3v4h3v12h5v-12h3.642l.358-4h-4v-1.667c0-.955.192-1.333 1.115-1.333h2.885v-5h-3.808c-3.596 0-5.192 1.583-5.192 4.615v3.385z"/>
				</svg>
			</a>
			<a href="https://www.tiktok.com/@lostboysk9academy" target="_blank" rel="noopener noreferrer" class="footer-social-link tiktok" aria-label="TikTok">
				<svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
					<path d="M19.59 6.69a4.83 4.83 0 0 1-3.77-4.25V2h-3.45v13.67a2.89 2.89 0 0 1-5.2 1.74 2.89 2.89 0 0 1 2.31-4.64 2.93 2.93 0 0 1 .88.13V9.4a6.84 6.84 0 0 0-1-.05A6.33 6.33 0 0 0 5 20.1a6.34 6.34 0 0 0 10.86-4.43v-7a8.16 8.16 0 0 0 4.77 1.52v-3.4a4.85 4.85 0 0 1-1-.1z"/>
				</svg>
			</a>
			<a href="https://www.youtube.com/@lostboysk9academy" target="_blank" rel="noopener noreferrer" class="footer-social-link youtube" aria-label="YouTube">
				<svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
					<path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>
				</svg>
			</a>
			<a href="https://x.com/Lostboysk9" target="_blank" rel="noopener noreferrer" class="footer-social-link twitter" aria-label="X">
				<svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
					<path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
				</svg>
			</a>
		</div>
		
		<div class="footer-logo">{isLostBoysTheme ? 'Lost Boys K9' : 'DIY K9'}</div>
		
		<p class="footer-disclosure">
			<strong>Affiliate Disclosure:</strong> I earn a commission when you purchase through my links 
			(code LOSTBOYSK9), at no additional cost to you. I only recommend products I personally use and trust. 
			All DIYK9 courses are created by Garret Wing of American Standard K9.
		</p>
		
		<p class="footer-copyright">
			© 2024 - <span class="highlight">2026</span> {isLostBoysTheme ? 'Lost Boys K9 Academy' : 'DIY K9 Affiliate'}
		</p>
	</div>
	
	<!-- Theme Toggle - Easter Egg -->
	<button class="theme-toggle" onclick={toggleTheme} aria-label="Toggle theme" title="Toggle Theme">
		{isLostBoysTheme ? '🐕' : '✨'}
	</button>
</footer>

<!-- Video Modals with Real DIYK9 Content -->
{#each courses as course}
	{#if activeModal === course.id}
		<!-- svelte-ignore a11y_no_static_element_interactions -->
		<div class="modal-overlay active" onclick={closeModal} role="button" tabindex="0">
			<div class="modal-content" onclick={(e) => e.stopPropagation()}>
				<button class="modal-close" onclick={closeModal} aria-label="Close modal">
					<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
						<path d="M18 6L6 18M6 6l12 12"/>
					</svg>
				</button>
				<div class="modal-video-container">
					<iframe
						src="https://www.youtube.com/embed/{course.videoId}?autoplay=1&rel=0&modestbranding=1&playsinline=1"
						title={course.title}
						frameborder="0"
						allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
						allowfullscreen
					></iframe>
				</div>
				<div class="modal-cta">
					<p class="modal-cta-text">{course.modalCta}</p>
					<div class="modal-features">
						<ul>
							{#each course.features as feature}
								<li>{feature}</li>
							{/each}
						</ul>
					</div>
					<p class="modal-price">Lifetime Access <span style="font-size: 0.7em; color: var(--color-gray-500);">• View pricing on enrollment page</span></p>
					<a href={course.link} class="btn btn-primary" target="_blank" rel="noopener">
						Enroll Now
						<span class="btn-glow"></span>
					</a>
					<p class="modal-guarantee">30-day money-back guarantee • Code LOSTBOYSK9 for 10% off</p>
				</div>
			</div>
		</div>
	{/if}
{/each}
