# Script para baixar as telas e imagens do projeto Stitch (FMA Pontos - Streaming)
# Salva tudo na pasta _reversa_sdd/stitch_screens/

$OutputDir = Join-Path (Get-Location) "_reversa_sdd/stitch_screens"
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
}

$Screens = @(
    @{
        Name = "Home_Acervo"
        HtmlUrl = "https://contribution.usercontent.google.com/download?c=CgthaWRhX2NvZGVmeBJ7Eh1hcHBfY29tcGFuaW9uX2dlbmVyYXRlZF9maWxlcxpaCiVodG1sXzBiMzQ2NThkNThjZTQwYmZiODNjNTBkZjQyMzhhZTVkEgsSBxDL3vDroRUYAZIBIwoKcHJvamVjdF9pZBIVQhMzNjM5MDY0MzU2NDgwMDk1MDMx&filename=&opi=96797242"
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0ugXg-VoexgGwWpe7op2WDYoEbYIJICgTuWh-SAFe-HJFM9QBseS1eHruVROYlrtSYUQGz_1ARqmU5MiymJaVzP1eNv006kivVCJAU6RAKWlE---9DKcufeYqTRTQNonjwVOiMgQ8ZjLnNormuub1E8UquJJ2VMl_3ou8InygieO3u3CleVjKg1VjUU3WtDdLkBCbLsknHctQd5SuTkByCAr8QTaRWNC21g1iNpKrKkhBJIQDnKVVMe09g"
    },
    @{
        Name = "Categoria_Ogum_1"
        HtmlUrl = "https://contribution.usercontent.google.com/download?c=CgthaWRhX2NvZGVmeBJ7Eh1hcHBfY29tcGFuaW9uX2dlbmVyYXRlZF9maWxlcxpaCiVodG1sX2Q1MDRkNjNlY2NkZTRhZGM4YTkxZTcyYTJiYTk4NDA1EgsSBxDL3vDroRUYAZIBIwoKcHJvamVjdF9pZBIVQhMzNjM5MDY0MzU2NDgwMDk1MDMx&filename=&opi=96797242"
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0uhewr2toNqj09cY86dhsDfT4o6eMoSeVrRDzmj1Kri7jXuzdMBE7_R4RROHurtmpXXmph4Nblh_pwxiBKS5-QATH8GMNxDohYFYKcAUE0d59hIQE8hfTcL96E-FpcPfJLpQ4cyF2MtCj9iHNFLM-TEDMLPGFMnb2E-aF6Tp7xma-zV_zoh4cg3JbPG_5ApiUw5i28ZuFgsUfHYBvkvTtTKdoAyuNHLLYPPiEdoW_QFO8VcLOgRMM2pfE7U"
    },
    @{
        Name = "Logo_Splash"
        HtmlUrl = $null
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0ujN0ZgxDs-q4-zBOdidss8GuEz4D9cH4e6R822kDWZHctmRDU0TN-6swgQEkgS_zk1zB1rggoU7geFOAFT-GDu93QVP1EpLk9orPWP451JZ1-54s4gup_lakxtiQjzKfFA0qSGRt1Pcr0wu2yl48wGWHkLjItpq9cE0j6En4q7VktVbWVZJoFYKzEDPFrLgisQ3HWxXDuXoPwclqgV6QX_UqWR_dWiKMu1QjfR0TwaH23bDjsrvtvmLilul2zibtOswqT_fbl5kTA"
    },
    @{
        Name = "Ogum_Shield_Sword"
        HtmlUrl = $null
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0uiZt96pppxioOHplcvC0V9dfCPv8nuiVOEYUrVaoaNz76zY1xuyWHXfIBkluzogWst8XmUWo9dHzTxK-xYXP2Ub3qGtPY1S9HrdpCkwYNAGPxCph9AErJboHYbkdmmkLLzLXBxUWn26Mw-D8ggL0E0QhFo7KuoPvOA6nGtg4KyDse_nwtnXlf_d-mGbldD8bRrNzNRWWC_o061nX-bNQaJiUBcxuvYVj2NDib0Q8x2lrYThlMmz5UE6JfQ"
    },
    @{
        Name = "Mais_Tocados"
        HtmlUrl = "https://contribution.usercontent.google.com/download?c=CgthaWRhX2NvZGVmeBJ7Eh1hcHBfY29tcGFuaW9uX2dlbmVyYXRlZF9maWxlcxpaCiVodG1sXzRlYjNmOTNiMzM4NjQ4MTlhY2VhMTY0MWU0NDNjZDMwEgsSBxDL3vDroRUYAZIBIwoKcHJvamVjdF9pZBIVQhMzNjM5MDY0MzU2NDgwMDk1MDMx&filename=&opi=96797242"
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0ugCBDG1JIYw3oPSCoPR3d23GMSeXqLYcJC3Z06yTQVgG4L6-D8WKXfXpTmfFJ5IgFEOOORqHS789qQBWclZCcneasV-flHBYEit7WY3xApIDy6TCDPL341wMrA6JgLlGOHry29KmW2bhgX6MS7M9CqCIGAr6YiVfPZROzIvQSQk00_3zZjw9ZUBcnzhSnbB-hPApRo-s6MAL5NEkqwPfUj2Yo3s_CxDWHNRFkNKhZAGd1fFSwRKTKUGqQ"
    },
    @{
        Name = "Painel_Administrativo"
        HtmlUrl = "https://contribution.usercontent.google.com/download?c=CgthaWRhX2NvZGVmeBJ7Eh1hcHBfY29tcGFuaW9uX2dlbmVyYXRlZF9maWxlcxpaCiVodG1sXzFiMDgzZTEyZTA0NjRhOTlhYTdhZGIxNTc1YThmYzJmEgsSBxDL3vDroRUYAZIBIwoKcHJvamVjdF9pZBIVQhMzNjM5MDY0MzU2NDgwMDk1MDMx&filename=&opi=96797242"
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0ui20ox_RtHOXHk3sQkrV-SvaY-5Pjd-tt_WVHfsCS4ULUQIYnKDjyudFK7GKrrbJ0wh6JlVZFmUHG5OfNZlvjKoFzoQpZiocdiyFCteh1NwskuB2br5tJf8thqnZHn6g_8TTc1O76RITjUnvPSRqehI30w5G622SCNxNTvZfuDOlWEHgJAdzPztuJsaidVVpEOaFb98y8LUa2KrkgFvIC7kCLXh1NMlQGsMLnJwOPQFoXgoj2qZyreffg"
    },
    @{
        Name = "Painel_Administrativo_Modernizado"
        HtmlUrl = "https://contribution.usercontent.google.com/download?c=CgthaWRhX2NvZGVmeBJ7Eh1hcHBfY29tcGFuaW9uX2dlbmVyYXRlZF9maWxlcxpaCiVodG1sXzIyYjJkMDBiM2UyMTQ4MGQ5ODBmNGVlZmQ3NDI5NzY1EgsSBxDL3vDroRUYAZIBIwoKcHJvamVjdF9pZBIVQhMzNjM5MDY0MzU2NDgwMDk1MDMx&filename=&opi=96797242"
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0uh7fS008yzufBqZJLHzUvUhTX-vwLXQAh8QnczNxPUX7oBBb27dsWq9sf_3DFIQtgO1pGpu05FfUnns2DHD_0vBgg_BCnigaHdsQLxubK3pTcGHnmvAf2PXHmNZU_F74jJ9W81-N58sJc-wO9wsGFdL9Su84N5B02WGAUdyshetQH9esPxYswtarxocVsdHzVeQwFbwpneW__EI9yWfQ8-QihpB2IjCBsi_PbRiQ7IIysRO-ysDMrKYdCo"
    },
    @{
        Name = "Categoria_Ogum_2"
        HtmlUrl = "https://contribution.usercontent.google.com/download?c=CgthaWRhX2NvZGVmeBJ7Eh1hcHBfY29tcGFuaW9uX2dlbmVyYXRlZF9maWxlcxpaCiVodG1sX2VjY2FhNjA3MDQ2MDRlMWRhNDQ3NzY2NzllMjZiM2YxEgsSBxDL3vDroRUYAZIBIwoKcHJvamVjdF9pZBIVQhMzNjM5MDY0MzU2NDgwMDk1MDMx&filename=&opi=96797242"
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0ujDS7cgUimUdqD6nmuRfpoPYzMnSxODfzMZ8Widqc7WUeFPJbpUZhNnxlrOCviXIB-mEeOqlISGdT2D6vUlPH_OQ1Dm7YnDwIeO07GoVpCR17Dn8y4RGPYUWhbHSnyehik8R6pi3EtgRP9436Z7IircPk3TLhFMgRY-G1AX7Ckhv0XraeSeJn3t3ryhehcugfNolrTEiBaUFkOtFAEH5W9qgZjr-roHdU5DNSSbnP9Touy2fRTywvx75nQ"
    },
    @{
        Name = "Mais_Tocados_Premium"
        HtmlUrl = "https://contribution.usercontent.google.com/download?c=CgthaWRhX2NvZGVmeBJ7Eh1hcHBfY29tcGFuaW9uX2dlbmVyYXRlZF9maWxlcxpaCiVodG1sXzg5Yzk1ZDljZGI1ZjQ5NzRiYjYwOTE1YWY2OTExZmE3EgsSBxDL3vDroRUYAZIBIwoKcHJvamVjdF9pZBIVQhMzNjM5MDY0MzU2NDgwMDk1MDMx&filename=&opi=96797242"
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0ugbtsaP2sEm6-rM9VbmEuniJzySTRNoNgSxP92COqV0Ja9EWEFlf9rkr2isRNuR1yVJgnaNQS476ZZPO3mNdDgmqlTu-BekJLUk6zttX6x1_L7J7DRH7YeejoiLwI-Kri5bVWOuqfj5IhoQI5pl94O0x8twoNbu1P4D1ISKnG2dSEx5NcYLqB3e2Mg4h6v666yUNlrnbmNdzWMUQER-Qz_1-KllUafkeczi60KIBnOWJISqDJ5qH7Jf4-A"
    },
    @{
        Name = "Busca"
        HtmlUrl = "https://contribution.usercontent.google.com/download?c=CgthaWRhX2NvZGVmeBJ7Eh1hcHBfY29tcGFuaW9uX2dlbmVyYXRlZF9maWxlcxpaCiVodG1sX2U0ZGI1ZjJlYWRmNjQ1ODY4NzM3ZGJmYTI1NGNlM2EyEgsSBxDL3vDroRUYAZIBIwoKcHJvamVjdF9pZBIVQhMzNjM5MDY0MzU2NDgwMDk1MDMx&filename=&opi=96797242"
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0ujsDJ6jDUGSmjC7vc7P3JKDCBDg7c_N12igDGQuxQrG-Pmr9CcIoZAARugjVO58u6CQXZkDS_inayTQ7AFuJ_Uwv8o6FrWDTOIQMu1fUkuNi1CPeDIj6FyO0FgW--87_a3vZ1FxjgNyAe83DXyium0CJcOHa4MnYr6U6cnATkPZCV-TlN7d9RDObCHn4L9mAeflw4UiDvW915mfEGDVm3kKe5VhNnPXaMufsnduUx1PuILcUylHPe1vH0E"
    },
    @{
        Name = "Spiritual_Banner"
        HtmlUrl = $null
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0uhNoGjzoW_B9cgsV9ZTeXnGJZFRmW2TDsBme8n2kKZ1dQxrYpPMzKSBXQLZ-NstpDteXH-tVIMBhxFvExuuq-sJhWNH4oD-IWaPGnPDr0fGVEwU3hMMCwe34yDm_LqW2x1S47WA4I4RF7R1zssPbCzRb1IjWp-_VwD87ozyg1_MNP4wRYN4NdEWzFTKCHmkmG2f0zVBzrit7l6qS-KkRtMOPeUiJrOH2f4Fa2L8H10QBbwWw24agwkncL8"
    },
    @{
        Name = "Tocando_Agora_Ogum"
        HtmlUrl = "https://contribution.usercontent.google.com/download?c=CgthaWRhX2NvZGVmeBJ7Eh1hcHBfY29tcGFuaW9uX2dlbmVyYXRlZF9maWxlcxpaCiVodG1sX2I3NDg4NGRjMDcyYjRhNDNhMzYyOTEwNmMyZjBhMDY0EgsSBxDL3vDroRUYAZIBIwoKcHJvamVjdF9pZBIVQhMzNjM5MDY0MzU2NDgwMDk1MDMx&filename=&opi=96797242"
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0ug0xFkFV3xVCPZIoTBU_tlQ8NaUtow3rKkimuGJOzksk2d-fsre5ESiWX-Oh5lNTZvWB2I9NkIfzVa-sIBlfJHegBZK3bCYcmTn1TSx-ACeVyIOT9H3NWe-EqIWZgKwwVnogmIIlWK5ufTcBTnK2o_lW6nR8H2LDWZtPpocHHtHySVOx_SomDfI23--cuGd6R-eljqzoJAnYYwQsII8gEcQVdz8xSwDYw6Eml3R-sFPOFfRUNvHRgQF8DY"
    },
    @{
        Name = "Onboarding"
        HtmlUrl = "https://contribution.usercontent.google.com/download?c=CgthaWRhX2NvZGVmeBJ7Eh1hcHBfY29tcGFuaW9uX2dlbmVyYXRlZF9maWxlcxpaCiVodG1sX2Y0ZjUwZDdjOGMxNTQxYTVhNDkwZGM2YWZiODA3ZDk3EgsSBxDL3vDroRUYAZIBIwoKcHJvamVjdF9pZBIVQhMzNjM5MDY0MzU2NDgwMDk1MDMx&filename=&opi=96797242"
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0uh5JlYUCoGMt7vbiLJDINy02U0Vpm5LxHwsYyLIJcIdMY5mQSFzrlLffuck65nEapCqQ9Lbgc62RrhiMrv9H0UyLK5CzAfTFNxdgnKvUhCaJ5m6JostD5gafJpcjqu_PyBXREKHPNyODax1qUITtFTqFTcIF7jPJCFYbR05Noa3FUpECtOBXmMHabrBBsqWugR-DLeYLgIzZaNo8pit91h4cHwB-5Af86yLkYV0RUf_IpNm9hUgymNpyVI"
    },
    @{
        Name = "Main_Cover"
        HtmlUrl = $null
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0uj7pCdvc4S4hrMHbu24UdnROGt7UbaJVyU6p6qAS6GGXN7wZ6JOR56aInvTzE4kbTyaRkCOuAluf9asmw6gmLxPmmbTU_KHt3CbDRcUr6zGBHpoJBgS9CrylBxCVN1cr5E4c9R6RhF9D3kApDnFH4nlyy1uV2ouNxSWn2t0o-fGNhVJj3hHJ8aoOZ9pfkG8a4OPp1Jgwf476wdxuVHMhPvL-45gb2GcBMS9oGddy6YsZW73SziWDi1hCe97DcgPtGwXZT9pMMbl-Q"
    },
    @{
        Name = "Novo_Ponto"
        HtmlUrl = "https://contribution.usercontent.google.com/download?c=CgthaWRhX2NvZGVmeBJ7Eh1hcHBfY29tcGFuaW9uX2dlbmVyYXRlZF9maWxlcxpaCiVodG1sX2Y4YmIwYTkzM2E1NzQ2MDY5MGY0Zjk3OTNlMzY0OTFiEgsSBxDL3vDroRUYAZIBIwoKcHJvamVjdF9pZBIVQhMzNjM5MDY0MzU2NDgwMDk1MDMx&filename=&opi=96797242"
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0ugLldsRglyVPeiuqJHffLlfL5kjeu6b5wozdJCQWNGj5oiRWxQdANRj78zPdewVit9Cwr3RAlRuUQ0fNmnRWeQ-wJ4usxvwrQc08I33dAd5ONNThGx0gzrvE_TznIRFp05hT0eIXuWEFxJUChCkD07Re8C4np58M0siy8WULbE3zBtQPAn_dbm8IZsUW6ycR8DRzrGHEkuJooh6ntmaajRiR7QXwvPvlPJeGfEUOp2uTxfMa4pnLVHlHgQ"
    },
    @{
        Name = "Onboarding_Privacidade"
        HtmlUrl = "https://contribution.usercontent.google.com/download?c=CgthaWRhX2NvZGVmeBJ7Eh1hcHBfY29tcGFuaW9uX2dlbmVyYXRlZF9maWxlcxpaCiVodG1sXzc3NmZiNTY0Y2Q2ODQzMWY5YzZiMjI5ODQ2N2ZhMDRkEgsSBxDL3vDroRUYAZIBIwoKcHJvamVjdF9pZBIVQhMzNjM5MDY0MzU2NDgwMDk1MDMx&filename=&opi=96797242"
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0ujkK_CQezrBbJgI73XrCs65GDv_jD89oyuPjdCf9liCElPe9_bZKSH9N639wmM319Uo7EU67mQ9EdI8GD0DCSKfDkWYi-T6an-Ye6ci9sBUWgcfgEqRpppuNGnUfpuYqyb0COw-Ck7RdB0Yd5vSaXTtlqwsZo2boghrOVZBkN7SbuDKfwb_Ol6s27PMHDtCNqBtsodSm2SyD2BnsRsZhaM3lYFzQRZkMf7QV8e8O634BxMMPMQRg20XShA"
    },
    @{
        Name = "Atabaque_Banner"
        HtmlUrl = $null
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0ugFBxZyunXKdl7pQRCYyydSHZk4XyZIqKLPZNgGxhwMlAZD4apAW9B5RM64EkvE--xv7rFr9Z9oppeCoxmcgz2xmb2U0JDw6-HzEdcrf_bPVnw80Mq9MDyv_BNvzwpYbNR3lywz6dlibwfcwNXljILEEYCsuZWs4n9i4eTYBzSy27fylF-kgh5O5ddJsmFpeV2wVAJnkt7pAK1J0vUkH8iCSqcZdsh3NfMn94vIZkoMywcvqsuF1Xy69oc"
    },
    @{
        Name = "Favoritos"
        HtmlUrl = "https://contribution.usercontent.google.com/download?c=CgthaWRhX2NvZGVmeBJ7Eh1hcHBfY29tcGFuaW9uX2dlbmVyYXRlZF9maWxlcxpaCiVodG1sXzY2ZTBiZTAyZjg5MjQwMDViODM2OTA2MTZkMDdmZDE0EgsSBxDL3vDroRUYAZIBIwoKcHJvamVjdF9pZBIVQhMzNjM5MDY0MzU2NDgwMDk1MDMx&filename=&opi=96797242"
        PngUrl = "https://lh3.googleusercontent.com/aida/ADBb0ui_fqMXrT5J9izV1CZjr2c805E-_kmCHBLM5l-DlnoRINDaERbHQ5dBX6Kr7Y43OOFzsty01a4QdD3mIWwlFbbc2p6hc6sHtf-jvSA1TyBPI0TetgtLKqg1PPIaLr1h18vwl-kWDDMJD3M8IsZ4731rY2RbRRhqRWxJiIZw1bxNGNDqcfy7N_fmbqtXPMfbXczaRxWJK-rn0drhPPpc8ihJVNfHVPkeW2ScgDEUgax88QW0P8l1Fcwv8G0"
    }
)

Write-Host "Iniciando download de $($Screens.Count) recursos do Stitch..." -ForegroundColor Green

foreach ($Screen in $Screens) {
    $Name = $Screen.Name
    Write-Host "Baixando recursos para: $Name" -ForegroundColor Cyan

    # Baixar HTML se disponível
    if ($Screen.HtmlUrl) {
        $DestHtml = Join-Path $OutputDir "$Name.html"
        try {
            Write-Host "  -> Baixando HTML..." -ForegroundColor DarkGray
            Invoke-RestMethod -Uri $Screen.HtmlUrl -OutFile $DestHtml
            Write-Host "  [OK] HTML salvo em $Name.html" -ForegroundColor Green
        } catch {
            Write-Host "  [ERRO] Falha ao baixar HTML para $($Name) - Erro: $_" -ForegroundColor Red
        }
    }

    # Baixar PNG se disponível
    if ($Screen.PngUrl) {
        $DestPng = Join-Path $OutputDir "$Name.png"
        try {
            Write-Host "  -> Baixando PNG..." -ForegroundColor DarkGray
            Invoke-RestMethod -Uri $Screen.PngUrl -OutFile $DestPng
            Write-Host "  [OK] Imagem salva em $Name.png" -ForegroundColor Green
        } catch {
            Write-Host "  [ERRO] Falha ao baixar PNG para $($Name) - Erro: $_" -ForegroundColor Red
        }
    }
}

Write-Host "Todos os downloads concluídos na pasta $OutputDir" -ForegroundColor Green
