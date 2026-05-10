<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>CondoDesk | Painel do Morador</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        :root { --purple: #7C3AED; --dark: #0F0A1F; --glass: rgba(255,255,255,0.03); --border: rgba(255,255,255,0.08); --muted: #94A3B8; }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: var(--dark); color: #F8FAFC; font-family: 'Space Grotesk', sans-serif; display: flex; min-height: 100vh; background-image: radial-gradient(circle at top right, #1A1035 0%, #0F0A1F 100%); }
        .sidebar { width: 240px; background: rgba(0,0,0,0.4); backdrop-filter: blur(20px); border-right: 1px solid var(--border); padding: 30px 20px; display: flex; flex-direction: column; }
        .brand { font-size: 1.3rem; font-weight: 700; margin-bottom: 40px; text-align: center; background: linear-gradient(to right, #FFF, var(--purple)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .nav-link { display: block; padding: 12px 16px; color: var(--muted); text-decoration: none; border-radius: 10px; margin-bottom: 8px; transition: 0.2s; font-size: 0.9rem; }
        .nav-link:hover { background: var(--glass); color: #FFF; }
        .nav-link.active { border-left: 3px solid var(--purple); background: rgba(124,58,237,0.05); color: #FFF; }
        .main { flex: 1; padding: 40px 50px; overflow-y: auto; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px; }
        .badge { background: rgba(124,58,237,0.2); color: #A78BFA; border: 1px solid var(--purple); padding: 6px 16px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
        .grid { display: grid; grid-template-columns: 1fr 2fr; gap: 20px; margin-bottom: 30px; }
        .card { background: var(--glass); border: 1px solid var(--border); border-radius: 20px; padding: 25px; }
        .card h5 { color: var(--muted); font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 15px; }
        .card p { margin-bottom: 8px; font-size: 0.95rem; }
        .card p strong { color: var(--muted); font-weight: 500; }
        .btn { display: inline-block; padding: 12px 24px; border-radius: 10px; text-decoration: none; font-weight: 600; font-size: 0.9rem; margin-right: 10px; transition: 0.2s; }
        .btn-primary { background: var(--purple); color: white; }
        .btn-primary:hover { opacity: 0.85; }
        .btn-outline { background: transparent; color: #FFF; border: 1px solid var(--border); }
        .btn-outline:hover { border-color: var(--purple); }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; color: var(--muted); font-size: 0.75rem; text-transform: uppercase; padding: 12px 15px; border-bottom: 1px solid var(--border); }
        td { padding: 15px; font-size: 0.9rem; border-bottom: 1px solid rgba(255,255,255,0.02); }
        .status { display: inline-block; padding: 4px 10px; border-radius: 8px; font-size: 0.75rem; font-weight: 600; background: rgba(124,58,237,0.15); color: #A78BFA; border: 1px solid rgba(124,58,237,0.3); }
        .empty { text-align: center; color: var(--muted); padding: 30px; }
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="brand">CondoDesk</div>
    <a href="/morador/painel" class="nav-link active">🏠 Início</a>
    <a href="/chamados/novo" class="nav-link">➕ Abrir Chamado</a>
    <a href="/logout" class="nav-link" style="color:#F87171; margin-top:40px;">🚪 Sair</a>
</aside>

<main class="main">
    <div class="header">
        <div>
            <h1 style="font-size:1.8rem;">Bem-vindo, ${usuarioLogado.nome}</h1>
            <p style="color:var(--muted); margin-top:5px;">Painel do Morador</p>
        </div>
        <span class="badge">MORADOR</span>
    </div>

    <div class="grid">
        <div class="card">
            <h5>Sua Unidade</h5>
            <c:choose>
                <c:when test="${not empty unidades}">
                    <p><strong>Número:</strong> ${unidades[0].numero}</p>
                    <p><strong>Bloco:</strong> ${unidades[0].bloco.identificacao}</p>
                    <p><strong>Andar:</strong> ${unidades[0].andar}º</p>
                </c:when>
                <c:otherwise>
                    <p style="color:var(--muted);">Nenhuma unidade vinculada.</p>
                    <p style="color:var(--muted); font-size:0.85rem;">Aguarde o administrador vincular sua unidade.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="card">
            <h5>Ações Rápidas</h5>
            <div style="margin-top:10px;">
                <a href="/chamados/novo" class="btn btn-primary">➕ Abrir Novo Chamado</a>
            </div>
        </div>
    </div>

    <div class="card">
        <h5>Seus Últimos Chamados</h5>
        <table>
            <thead>
                <tr>
                    <th>ID</th><th>Assunto</th><th>Status</th><th>Data</th><th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="chamado" items="${meusChamados}">
                    <tr>
                        <td style="color:var(--purple); font-weight:700;">#${chamado.id}</td>
                        <td>${chamado.titulo}</td>
                        <td><span class="status">${chamado.status}</span></td>
                        <td style="color:var(--muted); font-size:0.85rem;">${chamado.dataAbertura}</td>
                        <td><a href="/chamados/${chamado.id}" style="color:var(--purple); text-decoration:none;">Ver →</a></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty meusChamados}">
                    <tr><td colspan="5" class="empty">Você ainda não possui chamados abertos.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>