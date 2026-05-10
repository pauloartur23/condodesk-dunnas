<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>CondoDesk | Chamado #${chamado.id}</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        :root { --purple: #7C3AED; --dark: #0F0A1F; --glass: rgba(255,255,255,0.03); --border: rgba(255,255,255,0.08); --muted: #94A3B8; }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: var(--dark); color: #F8FAFC; font-family: 'Space Grotesk', sans-serif; display: flex; min-height: 100vh; background-image: radial-gradient(circle at top right, #1A1035 0%, #0F0A1F 100%); }
        .sidebar { width: 240px; background: rgba(0,0,0,0.4); border-right: 1px solid var(--border); padding: 30px 20px; display: flex; flex-direction: column; }
        .brand { font-size: 1.3rem; font-weight: 700; margin-bottom: 40px; text-align: center; background: linear-gradient(to right, #FFF, var(--purple)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .nav-link { display: block; padding: 12px 16px; color: var(--muted); text-decoration: none; border-radius: 10px; margin-bottom: 8px; font-size: 0.9rem; }
        .nav-link:hover { background: var(--glass); color: #FFF; }
        .main { flex: 1; padding: 40px 50px; max-width: 900px; }
        .header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 30px; }
        .badge { display: inline-block; padding: 6px 16px; border-radius: 20px; font-size: 0.8rem; font-weight: 700; background: rgba(124,58,237,0.2); color: #A78BFA; border: 1px solid var(--purple); }
        .badge.CONCLUIDO { background: rgba(16,185,129,0.2); color: #6EE7B7; border-color: #10B981; }
        .badge.EM_ATENDIMENTO { background: rgba(251,191,36,0.2); color: #FDE68A; border-color: #F59E0B; }
        .card { background: var(--glass); border: 1px solid var(--border); border-radius: 20px; padding: 25px; margin-bottom: 20px; }
        .card h4 { color: var(--muted); font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 15px; }
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .info-item label { display: block; color: var(--muted); font-size: 0.75rem; text-transform: uppercase; margin-bottom: 4px; }
        .info-item p { font-size: 0.95rem; }
        .comentario { padding: 15px 0; border-bottom: 1px solid var(--border); }
        .comentario:last-child { border-bottom: none; }
        .comentario-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; flex-wrap: wrap; gap: 8px; }
        .comentario-autor { font-weight: 600; font-size: 0.9rem; }
        .comentario-data { color: var(--muted); font-size: 0.8rem; }
        .comentario-texto { color: #CBD5E1; font-size: 0.9rem; line-height: 1.5; }
        .empty-comments { text-align: center; color: var(--muted); padding: 30px; }
        .comment-form { display: flex; gap: 10px; margin-top: 15px; }
        .comment-input { flex: 1; padding: 12px; background: rgba(0,0,0,0.4); border: 1px solid var(--border); border-radius: 10px; color: white; font-family: inherit; font-size: 0.9rem; }
        .comment-input:focus { border-color: var(--purple); outline: none; }
        .btn { padding: 10px 20px; border-radius: 10px; border: none; cursor: pointer; font-family: inherit; font-weight: 600; font-size: 0.85rem; }
        .btn-primary { background: var(--purple); color: white; }
        .btn-primary:hover { opacity: 0.85; }
        .btn-outline { background: transparent; color: var(--muted); border: 1px solid var(--border); text-decoration: none; display: inline-block; }
        .btn-outline:hover { border-color: var(--purple); color: white; }
        .status-form { display: flex; gap: 12px; align-items: center; flex-wrap: wrap; }
        .status-select { padding: 10px 14px; background: rgba(0,0,0,0.4); border: 1px solid var(--border); border-radius: 10px; color: white; font-family: inherit; font-size: 0.9rem; cursor: pointer; }
        .status-select:focus { border-color: var(--purple); outline: none; }
        .status-select option { background: #1A1035; }
        .alert-info { background: rgba(16,185,129,0.1); border: 1px solid rgba(16,185,129,0.3); border-radius: 10px; padding: 12px 16px; color: #6EE7B7; font-size: 0.85rem; margin-bottom: 15px; }
        /* CORRIGIDO: badges de tipo de usuário nos comentários */
        .badge-tipo-ADMIN { background: rgba(124,58,237,0.25); color: #A78BFA; border: 1px solid var(--purple); padding: 2px 8px; border-radius: 6px; font-size: 0.7rem; font-weight: 700; }
        .badge-tipo-COLABORADOR { background: rgba(251,191,36,0.2); color: #FDE68A; border: 1px solid #F59E0B; padding: 2px 8px; border-radius: 6px; font-size: 0.7rem; font-weight: 700; }
        .badge-tipo-MORADOR { background: rgba(59,130,246,0.2); color: #93C5FD; border: 1px solid #3B82F6; padding: 2px 8px; border-radius: 6px; font-size: 0.7rem; font-weight: 700; }
        .readonly-status { padding: 10px 14px; background: rgba(0,0,0,0.2); border: 1px solid var(--border); border-radius: 10px; color: var(--muted); font-size: 0.9rem; display: inline-block; }
        .no-permission-msg { color: var(--muted); font-size: 0.85rem; font-style: italic; margin-top: 15px; padding: 12px; background: var(--glass); border: 1px solid var(--border); border-radius: 10px; }
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
    <a href="/chamados" class="nav-link">📋 Chamados</a>
    <a href="/logout" class="nav-link" style="color:#F87171; margin-top:40px;">🚪 Sair</a>
</aside>

<main class="main">
    <div class="header">
        <div>
            <p style="color:var(--muted); font-size:0.85rem; margin-bottom:8px;">
                <a href="/chamados" style="color:var(--muted); text-decoration:none;">← Voltar aos chamados</a>
            </p>
            <h1 style="font-size:1.6rem; margin-bottom:10px;">#${chamado.id} — ${chamado.titulo}</h1>
            <span class="badge ${chamado.status}">${chamado.status}</span>
        </div>
    </div>

    <!-- Informações do Chamado -->
    <div class="card">
        <h4>Informações</h4>
        <div class="info-grid">
            <div class="info-item">
                <label>Unidade</label>
                <p>Bloco ${chamado.unidade.bloco.identificacao} — Apto ${chamado.unidade.numero}</p>
            </div>
            <div class="info-item">
                <label>Tipo</label>
                <p>${not empty chamado.tipoChamado ? chamado.tipoChamado : '—'}</p>
            </div>
            <div class="info-item">
                <label>Aberto em</label>
                <p>${chamado.dataAbertura}</p>
            </div>
            <div class="info-item">
                <label>Finalizado em</label>
                <p>${not empty chamado.dataFinalizacao ? chamado.dataFinalizacao : '—'}</p>
            </div>
        </div>
    </div>

    <!-- Descrição -->
    <div class="card">
        <h4>Descrição</h4>
        <p style="color:#CBD5E1; line-height:1.6;">${chamado.descricao}</p>
    </div>

    <!-- CORRIGIDO: Alterar Status — só aparece para ADMIN e COLABORADOR -->
    <c:choose>
        <c:when test="${usuarioLogado.tipo == 'ADMIN' || usuarioLogado.tipo == 'COLABORADOR'}">
            <div class="card">
                <h4>Alterar Status</h4>
                <form action="/chamados/${chamado.id}/status" method="post" class="status-form">
                    <select name="novoStatus" class="status-select">
                        <c:forEach items="${statusList}" var="s">
                            <option value="${s.nome}" ${chamado.status == s.nome ? 'selected' : ''}>${s.nome}</option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="btn btn-primary">Atualizar Status</button>
                </form>
            </div>
        </c:when>
        <c:otherwise>
            <!-- CORRIGIDO: morador vê apenas o status atual como texto readonly -->
            <div class="card">
                <h4>Status Atual</h4>
                <span class="readonly-status">${chamado.status}</span>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Comentários -->
    <div class="card">
        <h4>Comentários</h4>

        <c:choose>
            <c:when test="${empty comentarios}">
                <div class="empty-comments">Nenhum comentário ainda.</div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${comentarios}" var="com">
                    <div class="comentario">
                        <div class="comentario-header">
                            <div style="display:flex; align-items:center; gap:8px;">
                                <span class="comentario-autor">${com.usuario.nome}</span>
                                <!-- CORRIGIDO: badge de tipo de usuário com cor por papel -->
                                <c:choose>
                                    <c:when test="${com.usuario.tipo == 'ADMIN'}">
                                        <span class="badge-tipo-ADMIN">ADMIN</span>
                                    </c:when>
                                    <c:when test="${com.usuario.tipo == 'COLABORADOR'}">
                                        <span class="badge-tipo-COLABORADOR">COLABORADOR</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-tipo-MORADOR">MORADOR</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <span class="comentario-data">${com.dataComentario}</span>
                        </div>
                        <p class="comentario-texto">${com.texto}</p>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <!-- CORRIGIDO: form de comentar usa podeComentarFlag enviado pelo controller -->
        <c:choose>
            <c:when test="${podeComentarFlag}">
                <form action="/chamados/${chamado.id}/comentar" method="post" class="comment-form">
                    <input type="text" name="texto" placeholder="Escreva um comentário..." class="comment-input" required>
                    <button type="submit" class="btn btn-primary">Enviar</button>
                </form>
            </c:when>
            <c:otherwise>
                <p class="no-permission-msg">Você não tem permissão para comentar neste chamado.</p>
            </c:otherwise>
        </c:choose>
    </div>
</main>
</body>
</html>
