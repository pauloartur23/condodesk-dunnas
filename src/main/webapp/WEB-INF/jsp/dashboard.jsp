<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CondoDesk | Central de Comando</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <style>
        :root {
            --ai-purple: #7C3AED;
            --ai-dark: #0F0A1F;
            --glass: rgba(255, 255, 255, 0.03);
            --border: rgba(255, 255, 255, 0.08);
            --text-muted: #94A3B8;
        }
        body {
            background-color: var(--ai-dark);
            color: #F8FAFC;
            font-family: 'Space Grotesk', sans-serif;
            margin: 0;
            display: flex;
            min-height: 100vh;
            background-image: radial-gradient(circle at top right, #1A1035 0%, #0F0A1F 100%);
        }
        .sidebar {
            width: 260px;
            background: rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border);
            padding: 40px 20px;
            display: flex;
            flex-direction: column;
        }
        .brand {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 50px;
            text-align: center;
            background: linear-gradient(to right, #FFF, var(--ai-purple));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .nav-menu { list-style: none; padding: 0; margin: 0; }
        .nav-item { margin-bottom: 10px; }
        .nav-link {
            display: flex;
            align-items: center;
            padding: 14px 18px;
            color: var(--text-muted);
            text-decoration: none;
            border-radius: 12px;
            transition: 0.3s;
            font-size: 0.9rem;
        }
        .nav-link:hover { background: var(--glass); color: #FFF; }
        .nav-link.active {
            border-left: 4px solid var(--ai-purple);
            background: rgba(124, 58, 237, 0.05);
            color: #FFF;
        }
        .main-content { flex: 1; padding: 40px 60px; overflow-y: auto; }
        .header-ui {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }
        .user-profile {
            display: flex;
            align-items: center;
            gap: 15px;
            background: var(--glass);
            padding: 8px 20px;
            border-radius: 30px;
            border: 1px solid var(--border);
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 40px;
        }
        .stat-card {
            background: var(--glass);
            border: 1px solid var(--border);
            padding: 25px;
            border-radius: 24px;
            position: relative;
            overflow: hidden;
            transition: 0.3s;
        }
        .stat-card:hover { transform: translateY(-5px); border-color: var(--ai-purple); }
        .stat-card p { font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1.5px; color: var(--text-muted); margin: 0 0 10px 0; }
        .stat-card h2 { font-size: 2.2rem; margin: 0; font-weight: 700; }
        .stat-card::before { content: ''; position: absolute; bottom: 0; left: 0; width: 100%; height: 4px; background: var(--ai-purple); opacity: 0.6; }
        .dashboard-row {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
        }
        .glass-panel {
            background: var(--glass);
            border: 1px solid var(--border);
            border-radius: 28px;
            padding: 30px;
        }
        h3 { margin-top: 0; font-size: 1.1rem; margin-bottom: 25px; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; color: var(--text-muted); font-size: 0.75rem; padding: 15px; border-bottom: 1px solid var(--border); text-transform: uppercase; }
        td { padding: 18px 15px; font-size: 0.9rem; border-bottom: 1px solid rgba(255,255,255,0.02); }
        .status-badge {
            background: rgba(124, 58, 237, 0.15);
            color: #A78BFA;
            padding: 5px 12px;
            border-radius: 8px;
            font-size: 0.75rem;
            font-weight: 600;
            border: 1px solid rgba(124, 58, 237, 0.3);
        }
        #toast {
            position: fixed; bottom: 30px; right: 30px;
            background: var(--ai-purple);
            padding: 15px 30px; border-radius: 16px;
            box-shadow: 0 10px 40px rgba(124, 58, 237, 0.4);
            z-index: 9999; font-weight: 600;
        }
    </style>
</head>
<body>

<aside class="sidebar">
    <div class="brand">CondoDesk</div>
    <nav>
        <ul class="nav-menu">
            <li class="nav-item"><a href="/dashboard" class="nav-link active">📊 Dashboard</a></li>
            <li class="nav-item"><a href="/admin/blocos/novo" class="nav-link">🏢 Estruturas</a></li>
            <li class="nav-item"><a href="/admin/usuarios/novo" class="nav-link">👥 Usuários</a></li>
            <li class="nav-item"><a href="/admin/vinculos/novo" class="nav-link">🔗 Mapeamento</a></li>
            <li class="nav-item"><a href="/admin/tipos-chamado" class="nav-link">🏷️ Tipos de Chamado</a></li>
            <li class="nav-item"><a href="/admin/status" class="nav-link">🔄 Status</a></li>
            <li class="nav-item"><a href="/admin/chamados/novo" class="nav-link">🎫 Novo Chamado</a></li>
            <li class="nav-item"><a href="/chamados" class="nav-link">📋 Chamados</a></li>
            <li class="nav-item"><a href="/admin/auditoria" class="nav-link">🔍 Auditoria</a></li>
            <li class="nav-item" style="margin-top: 50px;"><a href="/logout" class="nav-link" style="color: #F87171;">🚪 Sair</a></li>
        </ul>
    </nav>
</aside>

<main class="main-content">
    <div class="header-ui">
        <div>
            <h1 style="margin:0; font-size: 1.8rem;">Central de Operações</h1>
            <p style="color: var(--text-muted); margin: 5px 0 0 0;">Bem-vindo de volta, Administrador.</p>
        </div>
        <div class="user-profile">
            <div style="width: 10px; height: 10px; background: #10B981; border-radius: 50%;"></div>
            <span style="font-size: 0.85rem; font-weight: 500;">SISTEMA ONLINE</span>
        </div>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <p>Estruturas</p>
            <h2>${totalBlocos}</h2>
        </div>
        <div class="stat-card">
            <p>Unidades</p>
            <h2>${totalUnidades}</h2>
        </div>
        <div class="stat-card">
            <p>Usuários</p>
            <h2>${totalUsuarios}</h2>
        </div>
        <div class="stat-card">
            <p>Chamados</p>
            <h2>${totalChamados}</h2>
        </div>
    </div>

    <div class="dashboard-row">
        <div class="glass-panel">
            <h3>📋 Ocorrências Recentes</h3>
            <table>
                <thead>
                    <tr>
                        <th>Protocolo</th>
                        <th>Assunto</th>
                        <th>Unidade</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${ultimosChamados}" var="c">
                        <tr>
                            <td style="color: var(--ai-purple); font-weight: 700;">
                                <a href="/chamados/${c.id}" style="color: var(--ai-purple); text-decoration: none;">#${c.id}</a>
                            </td>
                            <td>${c.titulo}</td>
                            <td style="color: var(--text-muted); font-size: 0.85rem;">${c.unidade.bloco.identificacao} - ${c.unidade.numero}</td>
                            <td><span class="status-badge">${c.status}</span></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty ultimosChamados}">
                        <tr><td colspan="4" style="text-align: center; color: var(--text-muted); padding: 30px;">Nenhum chamado registrado.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <div class="glass-panel" style="display: flex; flex-direction: column; align-items: center; justify-content: center;">
            <h3 style="width: 100%;">Saúde do Sistema</h3>
            <canvas id="ctxChart" style="max-width: 200px; max-height: 200px;"></canvas>
            <div style="margin-top: 20px; text-align: center;">
                <p style="font-size: 0.8rem; color: var(--text-muted);">Ocupação vs Capacidade</p>
            </div>
        </div>
    </div>
</main>

<div id="toast" class="animate__animated animate__fadeInUp">
    🚀 Sincronização em tempo real ativa
</div>

<script>
    const ocupado = parseInt("${totalUsuarios}");
    const livre = parseInt("${totalUnidades}") - ocupado;

    const ctx = document.getElementById('ctxChart').getContext('2d');
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Ocupado', 'Livre'],
            datasets: [{
                data: [ocupado, livre < 0 ? 0 : livre],
                backgroundColor: ['#7C3AED', 'rgba(255,255,255,0.05)'],
                borderWidth: 0,
                hoverOffset: 10
            }]
        },
        options: {
            plugins: { legend: { display: false } },
            cutout: '85%'
        }
    });

    setTimeout(() => {
        const t = document.getElementById('toast');
        t.classList.replace('animate__fadeInUp', 'animate__fadeOutDown');
    }, 4000);
</script>
</body>
</html>