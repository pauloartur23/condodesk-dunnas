<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CondoDesk | Acesso ao Sistema</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --purple:      #7C3AED;
            --purple-dark: #5B21B6;
            --purple-glow: rgba(124,58,237,0.35);
            --bg:          #08051A;
            --glass:       rgba(255,255,255,0.03);
            --border:      rgba(255,255,255,0.07);
            --muted:       #64748B;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Space Grotesk', sans-serif;
            background: var(--bg);
            color: #F1F5F9;
            height: 100vh;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* ── CANVAS de fundo ── */
        #bgCanvas {
            position: fixed;
            inset: 0;
            z-index: 0;
            pointer-events: none;
        }

        /* ── Layout ── */
        .wrapper {
            position: relative;
            z-index: 10;
            display: flex;
            align-items: center;
            gap: 72px;
        }

        /* ══════════════════════════════
           PORTEIRO
        ══════════════════════════════ */
        .doorman-side {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
            user-select: none;
        }

        /* Bolha de fala */
        .bubble {
            position: relative;
            background: rgba(124,58,237,0.12);
            border: 1px solid rgba(124,58,237,0.35);
            border-radius: 18px 18px 18px 4px;
            padding: 12px 18px;
            max-width: 210px;
            font-size: 0.82rem;
            color: #C4B5FD;
            line-height: 1.5;
            text-align: center;
            transition: opacity 0.35s;
        }
        .bubble::after {
            content: '';
            position: absolute;
            bottom: -10px; left: 18px;
            border: 5px solid transparent;
            border-top-color: rgba(124,58,237,0.35);
        }

        /* SVG do porteiro */
        .doorman-svg {
            filter: drop-shadow(0 0 28px rgba(124,58,237,0.55));
            transition: filter 0.3s;
            cursor: default;
        }
        .doorman-svg:hover {
            filter: drop-shadow(0 0 48px rgba(124,58,237,0.9));
        }

        .doorman-label {
            font-size: 0.65rem;
            letter-spacing: 2.5px;
            text-transform: uppercase;
            color: rgba(124,58,237,0.65);
            font-weight: 600;
        }

        /* ══════════════════════════════
           CARD DE LOGIN
        ══════════════════════════════ */
        .card {
            width: 400px;
            background: rgba(255,255,255,0.025);
            backdrop-filter: blur(32px);
            -webkit-backdrop-filter: blur(32px);
            border: 1px solid var(--border);
            border-radius: 28px;
            padding: 48px 42px;
            box-shadow: 0 32px 80px rgba(0,0,0,0.55),
            inset 0 1px 0 rgba(255,255,255,0.06);
        }

        .card-logo {
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 3.5px;
            text-transform: uppercase;
            background: linear-gradient(135deg, #fff 0%, #A78BFA 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-align: center;
            margin-bottom: 6px;
        }

        .card-title {
            font-size: 1.65rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 4px;
            letter-spacing: -0.3px;
        }

        .card-sub {
            font-size: 0.8rem;
            color: var(--muted);
            text-align: center;
            margin-bottom: 34px;
        }

        /* Alerts */
        .alert {
            padding: 11px 14px;
            border-radius: 10px;
            font-size: 0.8rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .alert-error   { background: rgba(239,68,68,0.1);   color: #FCA5A5; border: 1px solid rgba(239,68,68,0.25); }
        .alert-success { background: rgba(16,185,129,0.1);  color: #6EE7B7; border: 1px solid rgba(16,185,129,0.25); }

        /* Campos */
        .field { margin-bottom: 16px; }
        .field label {
            display: block;
            font-size: 0.7rem;
            font-weight: 600;
            letter-spacing: 1.2px;
            text-transform: uppercase;
            color: #94A3B8;
            margin-bottom: 8px;
        }
        .field-wrap {
            position: relative;
        }
        .field-icon {
            position: absolute;
            left: 14px; top: 50%;
            transform: translateY(-50%);
            font-size: 0.95rem;
            pointer-events: none;
            opacity: 0.45;
        }
        .field input {
            width: 100%;
            padding: 13px 14px 13px 42px;
            background: rgba(0,0,0,0.32);
            border: 1px solid rgba(255,255,255,0.08);
            border-radius: 11px;
            color: #F1F5F9;
            font-family: 'Space Grotesk', sans-serif;
            font-size: 0.875rem;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .field input:focus {
            border-color: var(--purple);
            box-shadow: 0 0 0 3px rgba(124,58,237,0.18);
        }
        .field input::placeholder { color: #334155; }

        /* Botão */
        .btn-submit {
            width: 100%;
            padding: 14px;
            margin-top: 8px;
            background: linear-gradient(135deg, #7C3AED 0%, #5B21B6 100%);
            border: none;
            border-radius: 11px;
            color: #fff;
            font-family: 'Space Grotesk', sans-serif;
            font-weight: 700;
            font-size: 0.875rem;
            letter-spacing: 1.2px;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.22s;
            box-shadow: 0 8px 28px rgba(124,58,237,0.38);
            position: relative;
            overflow: hidden;
        }
        .btn-submit::before {
            content: '';
            position: absolute;
            top: 0; left: -100%;
            width: 100%; height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.08), transparent);
            transition: left 0.5s;
        }
        .btn-submit:hover::before { left: 100%; }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 14px 36px rgba(124,58,237,0.55);
        }
        .btn-submit:active { transform: translateY(0); }

        .divider {
            height: 1px;
            background: linear-gradient(to right, transparent, var(--border), transparent);
            margin: 26px 0;
        }

        .register-link {
            display: block;
            text-align: center;
            font-size: 0.8rem;
            color: var(--muted);
            text-decoration: none;
            transition: color 0.2s;
        }
        .register-link:hover { color: #A78BFA; }
        .register-link b { color: var(--purple); }

        /* Responsivo */
        @media (max-width: 780px) {
            .doorman-side { display: none; }
            .wrapper { gap: 0; }
        }
    </style>
</head>
<body>

<!-- Canvas de fundo animado -->
<canvas id="bgCanvas"></canvas>

<div class="wrapper">

    <!-- ═══════════ PORTEIRO DIGITAL ═══════════ -->
    <div class="doorman-side">
        <div class="bubble" id="bubble">Olá! Identifique-se para acessar o sistema 🏢</div>

        <svg class="doorman-svg" id="doorman" width="210" height="295"
             viewBox="0 0 210 295" xmlns="http://www.w3.org/2000/svg">
            <defs>
                <radialGradient id="gBody" cx="50%" cy="35%" r="60%">
                    <stop offset="0%" stop-color="#4C1D95"/>
                    <stop offset="100%" stop-color="#1E0A3C"/>
                </radialGradient>
                <radialGradient id="gHead" cx="42%" cy="30%" r="60%">
                    <stop offset="0%" stop-color="#6D28D9"/>
                    <stop offset="100%" stop-color="#2E1065"/>
                </radialGradient>
                <radialGradient id="gSkin" cx="45%" cy="35%" r="55%">
                    <stop offset="0%" stop-color="#7C3AED"/>
                    <stop offset="100%" stop-color="#3B1175"/>
                </radialGradient>
                <filter id="glow" x="-30%" y="-30%" width="160%" height="160%">
                    <feGaussianBlur stdDeviation="2.5" result="blur"/>
                    <feMerge><feMergeNode in="blur"/><feMergeNode in="SourceGraphic"/></feMerge>
                </filter>
                <filter id="softglow" x="-50%" y="-50%" width="200%" height="200%">
                    <feGaussianBlur stdDeviation="4" result="blur"/>
                    <feMerge><feMergeNode in="blur"/><feMergeNode in="SourceGraphic"/></feMerge>
                </filter>
                <!-- Gradiente do crachá -->
                <linearGradient id="gBadge" x1="0%" y1="0%" x2="100%" y2="100%">
                    <stop offset="0%" stop-color="rgba(124,58,237,0.4)"/>
                    <stop offset="100%" stop-color="rgba(91,33,182,0.2)"/>
                </linearGradient>
            </defs>

            <!-- Sombra -->
            <ellipse cx="105" cy="284" rx="58" ry="7" fill="rgba(0,0,0,0.4)"/>

            <!-- ── CORPO ── -->
            <rect x="53" y="155" width="104" height="108" rx="22"
                  fill="url(#gBody)" stroke="rgba(124,58,237,0.45)" stroke-width="1.5"/>

            <!-- Gravata -->
            <rect x="93" y="162" width="24" height="62" rx="7"
                  fill="rgba(124,58,237,0.25)" stroke="rgba(167,139,250,0.35)" stroke-width="1"/>
            <polygon points="93,162 117,162 110,184 100,184"
                     fill="rgba(124,58,237,0.5)"/>
            <!-- Nó da gravata -->
            <ellipse cx="105" cy="162" rx="8" ry="5"
                     fill="rgba(124,58,237,0.6)" stroke="rgba(167,139,250,0.5)" stroke-width="0.8"/>

            <!-- Crachá -->
            <rect x="118" y="172" width="26" height="17" rx="5"
                  fill="url(#gBadge)" stroke="rgba(167,139,250,0.5)" stroke-width="1"/>
            <rect x="121" y="176" width="10" height="4" rx="2" fill="rgba(167,139,250,0.5)"/>
            <rect x="121" y="182" width="18" height="2" rx="1" fill="rgba(167,139,250,0.3)"/>
            <circle cx="133" cy="178" r="3" fill="rgba(124,58,237,0.7)" stroke="rgba(167,139,250,0.6)" stroke-width="0.8"/>

            <!-- Botões do uniforme -->
            <circle cx="105" cy="198" r="2.5" fill="rgba(167,139,250,0.4)"/>
            <circle cx="105" cy="210" r="2.5" fill="rgba(167,139,250,0.4)"/>
            <circle cx="105" cy="222" r="2.5" fill="rgba(167,139,250,0.4)"/>

            <!-- ── BRAÇOS ── -->
            <!-- Esq -->
            <rect x="19" y="157" width="36" height="16" rx="8"
                  fill="url(#gBody)" stroke="rgba(124,58,237,0.4)" stroke-width="1.2"/>
            <ellipse cx="19" cy="165" rx="12" ry="9"
                     fill="url(#gSkin)" stroke="rgba(124,58,237,0.5)" stroke-width="1"/>
            <!-- Dedos esq (estilizado) -->
            <rect x="7" y="159" width="5" height="9" rx="2.5" fill="rgba(124,58,237,0.5)"/>
            <rect x="7" y="170" width="5" height="8" rx="2.5" fill="rgba(124,58,237,0.4)"/>

            <!-- Dir -->
            <rect x="155" y="157" width="36" height="16" rx="8"
                  fill="url(#gBody)" stroke="rgba(124,58,237,0.4)" stroke-width="1.2"/>
            <ellipse cx="191" cy="165" rx="12" ry="9"
                     fill="url(#gSkin)" stroke="rgba(124,58,237,0.5)" stroke-width="1"/>
            <!-- Dedos dir -->
            <rect x="198" y="159" width="5" height="9" rx="2.5" fill="rgba(124,58,237,0.5)"/>
            <rect x="198" y="170" width="5" height="8" rx="2.5" fill="rgba(124,58,237,0.4)"/>

            <!-- ── PESCOÇO ── -->
            <rect x="91" y="136" width="28" height="24" rx="7"
                  fill="url(#gHead)"/>

            <!-- ── CABEÇA ── -->
            <ellipse cx="105" cy="113" rx="50" ry="52"
                     fill="url(#gHead)" stroke="rgba(124,58,237,0.5)" stroke-width="1.5"/>

            <!-- Orelhas -->
            <ellipse cx="55" cy="115" rx="9" ry="12"
                     fill="#3B1175" stroke="rgba(124,58,237,0.4)" stroke-width="1"/>
            <ellipse cx="59" cy="115" rx="5" ry="7"
                     fill="rgba(124,58,237,0.2)"/>
            <ellipse cx="155" cy="115" rx="9" ry="12"
                     fill="#3B1175" stroke="rgba(124,58,237,0.4)" stroke-width="1"/>
            <ellipse cx="151" cy="115" rx="5" ry="7"
                     fill="rgba(124,58,237,0.2)"/>

            <!-- Cabelo -->
            <ellipse cx="105" cy="66" rx="48" ry="20" fill="#1E0A3C"/>
            <rect x="58" y="62" width="94" height="16" rx="5" fill="#1E0A3C"/>
            <!-- Risco do cabelo -->
            <line x1="105" y1="63" x2="105" y2="75"
                  stroke="rgba(124,58,237,0.3)" stroke-width="1.5"/>

            <!-- ── OLHO ESQUERDO ── -->
            <ellipse cx="84" cy="110" rx="16" ry="17"
                     fill="rgba(255,255,255,0.93)" filter="url(#glow)"/>
            <!-- Íris -->
            <circle cx="84" cy="110" r="10.5" fill="#5B21B6"/>
            <!-- Pupila (movida por JS) -->
            <circle id="pupilL" cx="84" cy="110" r="6" fill="#08051A"/>
            <!-- Reflexo -->
            <circle cx="88" cy="105" r="2.5" fill="rgba(255,255,255,0.75)"/>
            <circle cx="92" cy="108" r="1.2" fill="rgba(255,255,255,0.4)"/>

            <!-- ── OLHO DIREITO ── -->
            <ellipse cx="126" cy="110" rx="16" ry="17"
                     fill="rgba(255,255,255,0.93)" filter="url(#glow)"/>
            <circle cx="126" cy="110" r="10.5" fill="#5B21B6"/>
            <circle id="pupilR" cx="126" cy="110" r="6" fill="#08051A"/>
            <circle cx="130" cy="105" r="2.5" fill="rgba(255,255,255,0.75)"/>
            <circle cx="134" cy="108" r="1.2" fill="rgba(255,255,255,0.4)"/>

            <!-- Sobrancelhas (movidas por JS) -->
            <path id="browL" d="M70 91 Q84 84 98 91"
                  stroke="#A78BFA" stroke-width="3.5" fill="none" stroke-linecap="round"/>
            <path id="browR" d="M112 91 Q126 84 140 91"
                  stroke="#A78BFA" stroke-width="3.5" fill="none" stroke-linecap="round"/>

            <!-- Nariz -->
            <path d="M101 122 Q105 128 109 122"
                  stroke="rgba(124,58,237,0.5)" stroke-width="2" fill="none" stroke-linecap="round"/>

            <!-- Boca -->
            <path id="mouth" d="M90 137 Q105 147 120 137"
                  stroke="#A78BFA" stroke-width="2.8" fill="none" stroke-linecap="round"/>

            <!-- Reflexo testa -->
            <ellipse cx="97" cy="86" rx="16" ry="7"
                     fill="rgba(255,255,255,0.04)"/>
        </svg>

        <div class="doorman-label">Porteiro Digital — CondoDesk</div>
    </div>

    <!-- ═══════════ CARD LOGIN ═══════════ -->
    <div class="card">
        <div class="card-logo">CondoDesk</div>
        <div class="card-title">Bem-vindo de volta</div>
        <div class="card-sub">Sistema de Gestão Condominial</div>

        <% if ("true".equals(request.getParameter("erro"))) { %>
        <div class="alert alert-error">⚠️ Email ou senha incorretos.</div>
        <% } %>
        <% if ("true".equals(request.getParameter("registrado"))) { %>
        <div class="alert alert-success">✅ Cadastro realizado! Aguarde vínculo do admin.</div>
        <% } %>

        <form action="/logar" method="post">
            <div class="field">
                <label>Email</label>
                <div class="field-wrap">
                    <span class="field-icon">✉️</span>
                    <input type="email" name="email" placeholder="seu@email.com"
                           required autocomplete="email"
                           onfocus="onFocus('email')" onblur="onBlurField()"/>
                </div>
            </div>
            <div class="field">
                <label>Senha</label>
                <div class="field-wrap">
                    <span class="field-icon">🔒</span>
                    <input type="password" name="senha" placeholder="••••••••"
                           required autocomplete="current-password"
                           onfocus="onFocus('senha')" onblur="onBlurField()"/>
                </div>
            </div>
            <button type="submit" class="btn-submit">Entrar no Sistema</button>
        </form>

        <div class="divider"></div>
        <a href="/registrar" class="register-link">
            Não tem conta? <b>Cadastrar-se como Morador</b>
        </a>
    </div>

</div>

<script>
    /* ═══════════════════════════════════════════════
       CANVAS DE FUNDO — grade de pontos + linhas
    ═══════════════════════════════════════════════ */
    (function () {
        const canvas = document.getElementById('bgCanvas');
        const ctx = canvas.getContext('2d');
        let W, H, points;

        function resize() {
            W = canvas.width  = window.innerWidth;
            H = canvas.height = window.innerHeight;
            init();
        }

        function init() {
            points = [];
            const count = Math.floor((W * H) / 14000);
            for (let i = 0; i < count; i++) {
                points.push({
                    x: Math.random() * W,
                    y: Math.random() * H,
                    vx: (Math.random() - 0.5) * 0.3,
                    vy: (Math.random() - 0.5) * 0.3,
                    r: 1 + Math.random() * 2,
                    alpha: 0.15 + Math.random() * 0.45
                });
            }
        }

        function draw() {
            ctx.clearRect(0, 0, W, H);
            // linhas entre pontos próximos
            for (let i = 0; i < points.length; i++) {
                for (let j = i + 1; j < points.length; j++) {
                    const dx = points[i].x - points[j].x;
                    const dy = points[i].y - points[j].y;
                    const dist = Math.sqrt(dx * dx + dy * dy);
                    if (dist < 130) {
                        ctx.beginPath();
                        ctx.strokeStyle = `rgba(124,58,237,${0.12 * (1 - dist / 130)})`;
                        ctx.lineWidth = 0.6;
                        ctx.moveTo(points[i].x, points[i].y);
                        ctx.lineTo(points[j].x, points[j].y);
                        ctx.stroke();
                    }
                }
            }
            // pontos
            for (const p of points) {
                ctx.beginPath();
                ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
                ctx.fillStyle = `rgba(124,58,237,${p.alpha})`;
                ctx.fill();

                p.x += p.vx;
                p.y += p.vy;
                if (p.x < 0 || p.x > W) p.vx *= -1;
                if (p.y < 0 || p.y > H) p.vy *= -1;
            }
            requestAnimationFrame(draw);
        }

        window.addEventListener('resize', resize);
        resize();
        draw();
    })();

    /* ═══════════════════════════════════════════════
       PORTEIRO — olhos seguem cursor
    ═══════════════════════════════════════════════ */
    const svgEl  = document.getElementById('doorman');
    const pupilL = document.getElementById('pupilL');
    const pupilR = document.getElementById('pupilR');
    const browL  = document.getElementById('browL');
    const browR  = document.getElementById('browR');
    const mouth  = document.getElementById('mouth');
    const bubble = document.getElementById('bubble');

    // Posições base dos olhos no espaço SVG
    const EYE_L = { cx: 84,  cy: 110 };
    const EYE_R = { cx: 126, cy: 110 };
    const MAX_TRAVEL = 5.5;

    function movePupil(el, eyeBase, mouseX, mouseY, rect) {
        const eyeScreenX = rect.left + (eyeBase.cx / 210) * rect.width;
        const eyeScreenY = rect.top  + (eyeBase.cy / 295) * rect.height;
        const dx    = mouseX - eyeScreenX;
        const dy    = mouseY - eyeScreenY;
        const angle = Math.atan2(dy, dx);
        const dist  = Math.hypot(dx, dy);
        const t     = Math.min(dist / 160, 1) * MAX_TRAVEL;
        el.setAttribute('cx', (eyeBase.cx + Math.cos(angle) * t).toFixed(2));
        el.setAttribute('cy', (eyeBase.cy + Math.sin(angle) * t).toFixed(2));
    }

    let targetBrowShift = 0, currentBrowShift = 0;

    document.addEventListener('mousemove', e => {
        const rect = svgEl.getBoundingClientRect();
        movePupil(pupilL, EYE_L, e.clientX, e.clientY, rect);
        movePupil(pupilR, EYE_R, e.clientX, e.clientY, rect);

        const relY = (e.clientY - rect.top) / rect.height;
        targetBrowShift = relY < 0.35 ? -5 : relY > 0.75 ? 4 : 0;
    });

    // Sobrancelhas com easing
    (function animateBrows() {
        currentBrowShift += (targetBrowShift - currentBrowShift) * 0.12;
        const s = currentBrowShift;
        browL.setAttribute('d', `M70 ${91+s} Q84 ${84+s} 98 ${91+s}`);
        browR.setAttribute('d', `M112 ${91+s} Q126 ${84+s} 140 ${91+s}`);
        requestAnimationFrame(animateBrows);
    })();

    // Piscar
    function blink() {
        const origBL = browL.getAttribute('d');
        const origBR = browR.getAttribute('d');
        // sobrancelhas descem
        browL.style.transition = 'none';
        browR.style.transition = 'none';
        // simula fechar olhos reduzindo scale Y via stroke-width
        pupilL.setAttribute('ry', '1');
        pupilR.setAttribute('ry', '1');
        setTimeout(() => {
            pupilL.removeAttribute('ry');
            pupilR.removeAttribute('ry');
        }, 130);
        setTimeout(blink, 2800 + Math.random() * 3500);
    }
    setTimeout(blink, 1800);

    // Mensagens rotativas na bolha
    const msgs = [
        'Olá! Identifique-se para acessar o sistema 🏢',
        'Seus chamados estão me aguardando! 📋',
        'Sistema seguro e monitorado 🔐',
        'Bem-vindo ao CondoDesk! ✨',
        'Estou de olho em tudo por aqui 👀',
    ];
    let msgIdx = 0;
    setInterval(() => {
        msgIdx = (msgIdx + 1) % msgs.length;
        bubble.style.opacity = '0';
        setTimeout(() => {
            bubble.textContent = msgs[msgIdx];
            bubble.style.opacity = '1';
        }, 350);
    }, 4500);

    // Reação ao foco nos campos
    let smiling = false;
    function onFocus(field) {
        if (field === 'email') {
            bubble.textContent = 'Digite seu email de acesso 📧';
        } else {
            bubble.textContent = 'Vou olhar pro outro lado... 🙈';
            // olha para o lado
            pupilL.setAttribute('cx', String(EYE_L.cx - 5));
            pupilR.setAttribute('cx', String(EYE_R.cx - 5));
        }
        smiling = true;
        mouth.setAttribute('d', 'M90 137 Q105 150 120 137');
    }
    function onBlurField() {
        smiling = false;
        mouth.setAttribute('d', 'M90 137 Q105 147 120 137');
        bubble.textContent = msgs[msgIdx];
    }
</script>
</body>
</html>
