<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>CondoDesk | Chamados</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        :root { --purple: #7C3AED; --dark: #0F0A1F; --glass: rgba(255,255,255,0.03); --border: rgba(255,255,255,0.08); --muted: #94A3B8; }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: var(--dark); color: #F8FAFC; font-family: 'Space Grotesk', sans-serif; display: flex; min-height: 100vh; background-image: radial-gradient(circle at top right, #1A1035 0%, #0F0A1F 100%); }
        .sidebar { width: 240px; background: rgba(0,0,0,0.4); border-right: 1px solid var(--border); padding: 30px 20px; display: flex; flex-direction: column; }
        .brand { font-size: 1.3rem; font-weight: 700; margin-bottom: 40px; text-align: center; background: linear-gradient(to right, #FFF, var(--purple)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .nav-link { display: block; padding: 12px 16px; color: var(--muted); text-decoration: none; border-radius: 10px; margin-bottom: 8px; font-size: 0.9rem; }
        .nav-link:hover { background: var(--glass); color: #FFF; }
        .nav-link.active { border-left: 3px solid var(--purple); color: #FFF; }
        .main { flex: 1; padding: 40px 50px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        h1 { background: linear-gradient(to right, #FFF, var(--purple)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-size: 1.8rem; }
        .btn { display: inline-block; padding: 10px 22px; background: var(--purple); color: white; border-radius: 10px; text-decoration: none; font-weight: 600; font-size: 0.85rem; border: none; cursor: pointer; }
        .filtros { display: flex; gap: 10px; margin-bottom: 25px; flex-wrap: wrap; }
        .filtro-btn { padding: 8px 18px; border-radius: 20px; border: 1px solid var(--border); background: transparent; color: var(--muted); cursor: pointer; font-family: inherit; font-size: 0.8rem; text-decoration: none; }
        .filtro-btn:hover, .filtro-btn.ativo { border-color: var(--purple); color: #A78BFA; background: rgba(124,58,237,0.1); }
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px,1fr)); gap: 20px; }
        .card { background: var(--glass); border: 1px solid var(--border); border-radius: 20px; padding: 25px; transition: 0.2s; }
        .card:hover { border-color: var(--purple); transform: translateY(-3px); }
        .card a { text-decoration: none; color: inherit; display: block; }
        .status { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 0.7rem; font-weight: bold; background: rgba(124,58,237,0.2); color: #A78BFA; border: 1px solid var(--purple); margin-bottom: 12px; }
        .status.CONCLUIDO { background: rgba(16,185,129,0.2); color: #6EE7B7; border-color: #10B981; }
        .status.EM_ATENDIMENTO { background: rgba(251,191,36,0.2); color: #FDE68A; border-color: #F59E0B; }
        .unit-tag { color: var(--muted); font-size: 0.8rem; display: block; margin-bottom: 8px; }
        .empty { text-align: center; color: var(--muted); padding: 60px; grid-column: 1/-1; }
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="brand">CondoDesk</div>
    <c:choose>
        <c:when test="${usuarioLogado.tipo == 'ADMIN'}">
            <a href="/dashboard" class="nav-link">📊 Dashboard</a>
        </c:when>
        <c:when test="${usuarioLogado.tipo == 'COLABORADOR'}">
            <a href="/colaborador/painel" class="nav-link">📊 Painel</a>
        </c:when>
        <c:otherwise>
            <a href="/morador/painel" class="nav-link">🏠 Início</a>
        </c:otherwise>
    </c:choose>
    <a href="/chamados" class="nav-link active">📋 Chamados</a>
    <a href="/chamados/novo" class="nav-link">➕ Novo Chamado</a>
    <a href="/logout" class="nav-link" style="color:#F87171; margin-top:40px;">🚪 Sair</a>
</aside>

<main class="main">
    <div class="header">
        <h1>Painel de Chamados</h1>
        <a href="/chamados/novo" class="btn">+ Novo Chamado</a>
    </div>

    <div class="filtros">
        <a href="/chamados" class="filtro-btn ${empty param.status ? 'ativo' : ''}">Todos</a>
        <a href="/chamados?status=ABERTO" class="filtro-btn ${param.status == 'ABERTO' ? 'ativo' : ''}">Abertos</a>
        <a href="/chamados?status=EM_ATENDIMENTO" class="filtro-btn ${param.status == 'EM_ATENDIMENTO' ? 'ativo' : ''}">Em Atendimento</a>
        <a href="/chamados?status=CONCLUIDO" class="filtro-btn ${param.status == 'CONCLUIDO' ? 'ativo' : ''}">Concluídos</a>
    </div>

    <div class="grid">
        <c:forEach items="${chamados}" var="c">
            <div class="card">
                <a href="/chamados/${c.id}">
                    <span class="unit-tag">Bloco ${c.unidade.bloco.identificacao} — Apto ${c.unidade.numero}</span>
                    <span class="status ${c.status}">${c.status}</span>
                    <h3 style="margin-bottom:10px;">${c.titulo}</h3>
                    <p style="color:var(--muted); font-size:0.9rem; margin-bottom:12px;">${c.descricao}</p>
                    <small style="color:#475569;">Aberto em: ${c.dataAbertura}</small>
                </a>
            </div>
        </c:forEach>
        <c:if test="${empty chamados}">
            <div class="empty">Nenhum chamado encontrado.</div>
        </c:if>
    </div>
</main>
</body>
</html>